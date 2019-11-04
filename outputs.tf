output "cf_id" {
  value       = "${element(concat(aws_cloudfront_distribution.default.*.id, list("")), 0)}"
  description = "ID of AWS CloudFront distribution"
}

output "cf_arn" {
  value       = "${element(concat(aws_cloudfront_distribution.default.*.arn, list("")), 0)}"
  description = "ARN of AWS CloudFront distribution"
}

output "cf_aliases" {
  value       = "${var.aliases}"
  description = "Extra CNAMEs of AWS CloudFront"
}

output "cf_status" {
  value       = "${element(concat(aws_cloudfront_distribution.default.*.status, list("")), 0)}"
  description = "Current status of the distribution"
}

output "cf_domain_name" {
  value       = "${element(concat(aws_cloudfront_distribution.default.*.domain_name, list("")), 0)}"
  description = "Domain name corresponding to the distribution"
}

output "cf_etag" {
  value       = "${element(concat(aws_cloudfront_distribution.default.*.etag, list("")), 0)}"
  description = "Current version of the distribution's information"
}

output "cf_hosted_zone_id" {
  value       = "${element(concat(aws_cloudfront_distribution.default.*.hosted_zone_id, list("")), 0)}"
  description = "CloudFront Route 53 zone ID"
}

output "cf_origin_access_identity" {
  value       = "${aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path}"
  description = "A shortcut to the full path for the origin access identity to use in CloudFront"
}
