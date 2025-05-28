provider "aws" {
  region = var.region
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "Managed by Terraform"
}

module "website" {
  source = "../../"

  origin_domain_name = var.origin_domain_name
  custom_origins = [
    {
      domain_name = "assets.s3.us-east-1.amazonaws.com"
      origin_id   = "assets"
      s3_origin_config = {
        origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
      }
    }
  ]

  ordered_cache = [
    {
      target_origin_id = "assets"
      path_pattern     = "/static/*"
    }
  ]

  logging_enabled = var.logging_enabled
  context         = module.this.context
}

module "api" {
  source = "../../"

  origin_domain_name = var.origin_domain_name
  origin_shield = {
    enabled = true
    region  = "us-east-1"
  }

  custom_origins = [
    {
      domain_name           = "api.example.com"
      origin_id             = "grpc"
      https_port            = 443
      origin_protocl_policy = "https-only"
      origin_ssl_protocols  = ["TLSv1.2"]
      custom_origin_config = {
        origin_keepalive_timeout = 15
        origin_read_timeout      = 45
      }
    }
  ]

  custom_error_response = [
    {
      error_code = 404
    },
    {
      error_caching_min_ttl = 10
      error_code            = 403
      response_code         = 404
      response_page_path    = "/errors/404.html"
    }
  ]

  ordered_cache = [
    {
      target_origin_id = "grpc"
      path_pattern     = "/UserService/*"
      allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
      min_ttl          = 0
      default_ttl      = 0
      max_ttl          = 0
      grpc_config = {
        enabled = true
      }
    }
  ]

  logging_enabled = var.logging_enabled
  context         = module.this.context
}
