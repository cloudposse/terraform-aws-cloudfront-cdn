provider "aws" {
  region = var.region
}

module "website" {
  source = "../../"

  origin_domain_name = var.origin_domain_name
  custom_origins = [
    {
      domain_name = "assets.example.com"
      origin_id   = "assets"
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

  custom_origins = [
    {
      domain_name           = "api.example.com"
      origin_id             = "grpc"
      https_port            = 443
      origin_protocl_policy = "https-only"
      origin_ssl_protocols  = ["TLSv1.2"]
    }
  ]

  ordered_cache = [
    {
      target_origin_id = "grpc"
      path_pattern     = "/UserService/*"
      allowed_methods  = ["GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS"]
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
