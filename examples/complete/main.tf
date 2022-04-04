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
