provider "aws" {
  region = var.region
}

resource "aws_cloudfront_origin_access_control" "s3" {
  name                              = "${var.name}-s3-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_origin_access_identity" "custom" {
  comment = "${var.name}-custom"
}

# Public S3 endpoint without any OAI/OAC
module "s3_plain" {
  source = "../../"

  origin_domain_name = var.origin_domain_name
  origin_type        = "custom"

  logging_enabled = var.logging_enabled
  context         = module.this.context
}

module "s3_oac" {
  source = "../../"

  origin_domain_name       = var.origin_domain_name
  origin_type              = var.origin_type
  origin_access_control_id = aws_cloudfront_origin_access_control.s3.id

  logging_enabled = var.logging_enabled
  context         = module.this.context
}

module "s3_oai_default" {
  source = "../../"

  origin_domain_name = var.origin_domain_name
  origin_type        = var.origin_type

  logging_enabled = var.logging_enabled
  context         = module.this.context
}

module "s3_oai_custom" {
  source = "../../"

  origin_domain_name = var.origin_domain_name
  origin_type        = var.origin_type
  s3_origin_config = {
    origin_access_identity = aws_cloudfront_origin_access_identity.custom.cloudfront_access_identity_path
  }

  logging_enabled = var.logging_enabled
  context         = module.this.context
}
