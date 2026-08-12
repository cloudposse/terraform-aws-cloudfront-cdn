output "cdn_mtls_domain_name" {
  description = "Domain name of the mTLS-enabled CloudFront distribution"
  value       = module.cdn_mtls.cf_domain_name
}

output "cdn_mtls_id" {
  description = "ID of the mTLS-enabled CloudFront distribution"
  value       = module.cdn_mtls.cf_id
}

output "cdn_no_mtls_domain_name" {
  description = "Domain name of the CloudFront distribution without mTLS"
  value       = module.cdn_no_mtls.cf_domain_name
}

output "trust_store_id" {
  description = "ID of the CloudFront trust store"
  value       = aws_cloudfront_trust_store.this.id
}
