provider "aws" {
  region = var.region
}

# -----------------------------------------------------------------------------
# Private origin: an internal ALB reachable only via a CloudFront VPC origin
# -----------------------------------------------------------------------------

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "alb" {
  name_prefix = "${module.this.id}-"
  vpc_id      = data.aws_vpc.default.id

  tags = module.this.tags
}

resource "aws_vpc_security_group_egress_rule" "alb_all_outbound" {
  security_group_id = aws_security_group.alb.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

  tags = module.this.tags
}

# CloudFront creates (or reuses) this security group in the VPC the first time a
# VPC origin targets it. The origin's own security group must allow inbound
# traffic from it.
# https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-vpc-origins.html
data "aws_security_group" "cloudfront_vpc_origins" {
  vpc_id = data.aws_vpc.default.id
  name   = "CloudFront-VPCOrigins-Service-SG"

  depends_on = [aws_cloudfront_vpc_origin.this]
}

resource "aws_vpc_security_group_ingress_rule" "alb_from_cloudfront_vpc_origins" {
  security_group_id            = aws_security_group.alb.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = data.aws_security_group.cloudfront_vpc_origins.id

  tags = module.this.tags
}

resource "aws_lb" "internal" {
  name               = module.this.id
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = data.aws_subnets.default.ids

  tags = module.this.tags
}

resource "aws_lb_target_group" "internal" {
  name     = module.this.id
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  tags = module.this.tags
}

resource "aws_lb_listener" "internal" {
  load_balancer_arn = aws_lb.internal.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal.arn
  }
}

# -----------------------------------------------------------------------------
# CloudFront VPC origin
# -----------------------------------------------------------------------------

resource "aws_cloudfront_vpc_origin" "this" {
  vpc_origin_endpoint_config {
    name                   = module.this.id
    arn                    = aws_lb.internal.arn
    http_port              = 80
    https_port             = 443
    origin_protocol_policy = "http-only"

    origin_ssl_protocols {
      items    = ["TLSv1.2"]
      quantity = 1
    }
  }

  tags = module.this.tags
}

# -----------------------------------------------------------------------------
# CloudFront CDN backed by the VPC origin
# -----------------------------------------------------------------------------

module "cdn" {
  source = "../../"

  origin_domain_name = aws_lb.internal.dns_name
  origin_type        = "vpc"
  logging_enabled    = var.logging_enabled

  vpc_origin_config = {
    vpc_origin_id = aws_cloudfront_vpc_origin.this.id
  }

  context = module.this.context
}
