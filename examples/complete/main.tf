provider "aws" {
  region = var.region
}

module "cdn" {
  source = "../../"

  context = module.this.context

  aliases            = var.aliases
  origin_domain_name = var.origin_domain_name
  parent_zone_name   = var.parent_zone_name
}
