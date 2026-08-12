provider "aws" {
  region = var.region
}

# -----------------------------------------------------------------------------
# Self-signed CA for testing mTLS
# -----------------------------------------------------------------------------

resource "tls_private_key" "ca" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.ca.private_key_pem

  subject {
    common_name  = "Test CA"
    organization = "Test"
  }

  validity_period_hours = 8760
  is_ca_certificate     = true

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}

# -----------------------------------------------------------------------------
# S3 bucket for the CA cert bundle (trust store source)
# -----------------------------------------------------------------------------

resource "random_id" "this" {
  byte_length = 4
}

resource "aws_s3_bucket" "certs" {
  bucket = "mtls-example-certs-${random_id.this.hex}"
}

resource "aws_s3_bucket_public_access_block" "certs" {
  bucket = aws_s3_bucket.certs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "ca_bundle" {
  bucket  = aws_s3_bucket.certs.id
  key     = "ca-bundle.pem"
  content = tls_self_signed_cert.ca.cert_pem
}

# -----------------------------------------------------------------------------
# CloudFront Trust Store
# -----------------------------------------------------------------------------

resource "aws_cloudfront_trust_store" "this" {
  name = "mtls-example-${random_id.this.hex}"

  ca_certificates_bundle_source {
    ca_certificates_bundle_s3_location {
      bucket = aws_s3_bucket.certs.id
      key    = aws_s3_object.ca_bundle.key
      region = var.region
    }
  }

  depends_on = [aws_s3_object.ca_bundle]
}

# -----------------------------------------------------------------------------
# CloudFront CDN with mTLS enabled
# -----------------------------------------------------------------------------

module "cdn_mtls" {
  source = "../../"

  origin_domain_name = var.origin_domain_name
  origin_type        = "custom"
  logging_enabled    = var.logging_enabled

  viewer_mtls_config = {
    mode                           = "required"
    trust_store_id                 = aws_cloudfront_trust_store.this.id
    advertise_trust_store_ca_names = true
    ignore_certificate_expiry      = false
  }

  context = module.this.context
}

# -----------------------------------------------------------------------------
# CloudFront CDN without mTLS (verify no-op when not configured)
# -----------------------------------------------------------------------------

module "cdn_no_mtls" {
  source = "../../"

  origin_domain_name = var.origin_domain_name
  origin_type        = "custom"
  logging_enabled    = var.logging_enabled

  context = module.this.context
}
