output "cf_id" {
  value       = module.cdn.cf_id
  description = "ID of CloudFront distribution"
}

output "cf_arn" {
  value       = module.cdn.cf_arn
  description = "ARN of CloudFront distribution"
}

output "cf_aliases" {
  value       = var.aliases
  description = "Extra CNAMEs of AWS CloudFront"
}

output "cf_status" {
  value       = module.cdn.cf_status
  description = "Current status of the distribution"
}

output "cf_domain_name" {
  value       = module.cdn.cf_domain_name
  description = "Domain name corresponding to the distribution"
}

output "cf_etag" {
  value       = module.cdn.cf_etag
  description = "Current version of the distribution's information"
}

output "cf_hosted_zone_id" {
  value       = module.cdn.cf_hosted_zone_id
  description = "CloudFront Route 53 Zone ID"
}

output "cf_origin_access_identity" {
  value       = module.cdn.cf_origin_access_identity
  description = "A shortcut to the full path for the origin access identity to use in CloudFront"
}
