provider "aws" {
  region = var.region
}

module "cdn" {
  source = "../../"

  aliases            = var.aliases
  origin_domain_name = var.origin_domain_name
  parent_zone_name   = var.parent_zone_name
  log_force_destroy  = true

  context = module.this.context
}

# -----------------------------------------------------------------------------
# Private origin: an internal ALB reachable only via a CloudFront VPC origin.
# Uses a dedicated VPC (not the default one).
# -----------------------------------------------------------------------------

module "vpc_origin_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["vpc"]

  context = module.this.context
}

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "3.0.0"

  ipv4_primary_cidr_block = var.vpc_cidr_block

  context = module.vpc_origin_label.context
}

module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "3.1.1"

  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = [module.vpc.igw_id]
  ipv4_cidr_block      = [module.vpc.vpc_cidr_block]
  nat_gateway_enabled  = false
  nat_instance_enabled = false

  context = module.vpc_origin_label.context
}

# The ALB only accepts traffic from CloudFront. The module's own security group is
# disabled because it always opens HTTP to `http_ingress_cidr_blocks`.
resource "aws_security_group" "alb" {
  name_prefix = "${module.vpc_origin_label.id}-"
  description = "Allows HTTP from CloudFront VPC origins only"
  vpc_id      = module.vpc.vpc_id

  tags = module.vpc_origin_label.tags
}

resource "aws_vpc_security_group_egress_rule" "alb_all_outbound" {
  security_group_id = aws_security_group.alb.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

  tags = module.vpc_origin_label.tags
}

# CloudFront creates (or reuses) this security group in the VPC the first time a
# VPC origin targets it. The origin's own security group must allow inbound
# traffic from it.
# https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-vpc-origins.html
data "aws_security_group" "cloudfront_vpc_origins" {
  vpc_id = module.vpc.vpc_id
  name   = "CloudFront-VPCOrigins-Service-SG"

  depends_on = [aws_cloudfront_vpc_origin.this]
}

resource "aws_vpc_security_group_ingress_rule" "alb_from_cloudfront_vpc_origins" {
  security_group_id            = aws_security_group.alb.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = data.aws_security_group.cloudfront_vpc_origins.id

  tags = module.vpc_origin_label.tags
}

module "alb" {
  source  = "cloudposse/alb/aws"
  version = "2.5.0"

  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.subnets.private_subnet_ids
  internal               = true
  http_enabled           = true
  access_logs_enabled    = false
  security_group_enabled = false
  security_group_ids     = [aws_security_group.alb.id]

  context = module.vpc_origin_label.context
}

resource "aws_cloudfront_vpc_origin" "this" {
  vpc_origin_endpoint_config {
    name                   = module.vpc_origin_label.id
    arn                    = module.alb.alb_arn
    http_port              = 80
    https_port             = 443
    origin_protocol_policy = "http-only"

    origin_ssl_protocols {
      items    = ["TLSv1.2"]
      quantity = 1
    }
  }

  tags = module.vpc_origin_label.tags
}

module "cdn_vpc_origin" {
  source = "../../"

  origin_domain_name = module.alb.alb_dns_name
  origin_type        = "vpc"
  log_force_destroy  = true

  vpc_origin_config = {
    vpc_origin_id = aws_cloudfront_vpc_origin.this.id
  }

  context = module.vpc_origin_label.context
}
