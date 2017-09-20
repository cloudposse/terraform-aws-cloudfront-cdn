output "cf_id" {
  value = "${aws_cloudfront_distribution.default.id}"
}

output "cf_arn" {
  value = "${aws_cloudfront_distribution.default.arn}"
}

output "cf_aliases" {
  value = "${aws_cloudfront_distribution.default.aliases}"
}

output "cf_status" {
  value = "${aws_cloudfront_distribution.default.status}"
}

output "cf_domain_name" {
  value = "${aws_cloudfront_distribution.default.domain_name}"
}

output "cf_etag" {
  value = "${aws_cloudfront_distribution.default.etag}"
}

output "cf_hosted_zone_id" {
  value = "${aws_cloudfront_distribution.default.hosted_zone_id}"
}

output "cf_origin_access_identity" {
  value = "${aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path}"
}
