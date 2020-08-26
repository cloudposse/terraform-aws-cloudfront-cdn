provider "aws" {
  region = var.region
}

module "cdn" {
  source     = "../../"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  attributes = var.attributes
  region     = var.region

  aliases                           = var.aliases
  origin_domain_name                = var.origin_domain_name
  parent_zone_name                  = var.parent_zone_name
}
