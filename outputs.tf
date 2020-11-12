output "cf_id" {
  value       = try(aws_cloudfront_distribution.default[0].id, "")
  description = "ID of CloudFront distribution"
}

output "cf_arn" {
  value       = try(aws_cloudfront_distribution.default[0].arn, "")
  description = "ARN of CloudFront distribution"
}

output "cf_aliases" {
  value       = var.aliases
  description = "Extra CNAMEs of AWS CloudFront"
}

output "cf_status" {
  value       = try(aws_cloudfront_distribution.default[0].status, "")
  description = "Current status of the distribution"
}

output "cf_domain_name" {
  value       = try(aws_cloudfront_distribution.default[0].domain_name, "")
  description = "Domain name corresponding to the distribution"
}

output "cf_etag" {
  value       = try(aws_cloudfront_distribution.default[0].etag, "")
  description = "Current version of the distribution's information"
}

output "cf_hosted_zone_id" {
  value       = try(aws_cloudfront_distribution.default[0].hosted_zone_id, "")
  description = "CloudFront Route 53 Zone ID"
}

output "cf_origin_access_identity" {
  value       = try(aws_cloudfront_origin_access_identity.default[0].cloudfront_access_identity_path, "")
  description = "A shortcut to the full path for the origin access identity to use in CloudFront"
}

output "logs" {
  value       = module.logs
  description = "Logs resource"
}
