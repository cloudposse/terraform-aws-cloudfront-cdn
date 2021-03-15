provider "aws" {
  region = var.region
}

resource "random_id" "id" {
  byte_length = 8
}

module "cdn" {
  source = "../../"

  aliases            = var.aliases
  origin_domain_name = var.origin_domain_name
  parent_zone_name   = var.parent_zone_name
  attributes         = [random_id.id.hex]
  log_force_destroy  = true

  context = module.this.context
}
