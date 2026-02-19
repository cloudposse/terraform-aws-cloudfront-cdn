variable "distribution_enabled" {
  type        = bool
  default     = true
  description = "Set to `true` if you want CloudFront to begin processing requests as soon as the distribution is created, or to false if you do not want CloudFront to begin processing requests after the distribution is created."
}

variable "dns_aliases_enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent dns records for aliases from being created"
}

variable "acm_certificate_arn" {
  type        = string
  description = "Existing ACM Certificate ARN"
  default     = ""
}

variable "aliases" {
  type        = list(string)
  default     = []
  description = "List of aliases. CAUTION! Names MUSTN'T contain trailing `.`"
}

variable "custom_error_response" {
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html#custom-error-pages-procedure
  # https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html#custom-error-response-arguments
  type = list(object({
    error_caching_min_ttl = optional(string, null)
    error_code            = string
    response_code         = optional(string, null)
    response_page_path    = optional(string, null)
  }))

  description = "List of one or more custom error response element maps"
  default     = []
}

variable "custom_header" {
  type = list(object({
    name  = string
    value = string
  }))

  description = "List of one or more custom headers passed to the origin"
  default     = []
}

variable "web_acl_id" {
  type        = string
  description = "ID of the AWS WAF web ACL that is associated with the distribution"
  default     = ""
}

variable "origin_domain_name" {
  type        = string
  description = "The DNS domain name of your custom origin (e.g. website)"
  default     = ""
}

variable "origin_path" {
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginPath
  type        = string
  description = "An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin. It must begin with a /. Do not add a / at the end of the path."
  default     = ""
}

variable "origin_access_control_id" {
  # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html
  type        = string
  description = "CloudFront provides two ways to send authenticated requests to an Amazon S3 origin: origin access control (OAC) and origin access identity (OAI). OAC helps you secure your origins, such as for Amazon S3."
  default     = null
}

variable "origin_http_port" {
  type        = number
  description = "The HTTP port the custom origin listens on"
  default     = "80"
}

variable "origin_https_port" {
  type        = number
  description = "The HTTPS port the custom origin listens on"
  default     = 443
}

variable "origin_protocol_policy" {
  type        = string
  description = "The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer"
  default     = "match-viewer"
}

variable "origin_shield" {
  type = object({
    enabled = optional(bool, false)
    region  = optional(string, null)
  })
  description = "The CloudFront Origin Shield settings"
  default     = null
}

variable "origin_ssl_protocols" {
  description = "The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS"
  type        = list(string)
  default     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
}

variable "origin_keepalive_timeout" {
  type        = number
  description = "The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
  default     = 5
}

variable "origin_read_timeout" {
  type        = number
  description = "The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
  default     = 30
}

variable "response_completion_timeout" {
  type        = number
  description = "Time (in seconds) that a request from CloudFront to the origin can stay open and wait for a response. Must be integer greater than or equal to the value of origin_read_timeout. If omitted or explicitly set to 0, no maximum value is enforced."
  default     = 0
}

variable "compress" {
  type        = bool
  description = "Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false)"
  default     = false
}

variable "is_ipv6_enabled" {
  type        = bool
  default     = true
  description = "State of CloudFront IPv6"
}

variable "default_root_object" {
  type        = string
  default     = "index.html"
  description = "Object that CloudFront return when requests the root URL"
}

variable "comment" {
  type        = string
  default     = "Managed by Terraform"
  description = "Comment for the origin access identity"
}

variable "origin_access_identity_enabled" {
  type        = bool
  default     = true
  description = "When true, creates origin access identity resource"
}

variable "logging_enabled" {
  type        = bool
  default     = true
  description = "When true, access logs will be sent to a newly created s3 bucket"
}

variable "log_include_cookies" {
  type        = bool
  default     = false
  description = "Include cookies in access logs"
}

variable "log_prefix" {
  type        = string
  default     = ""
  description = "Path of logs in S3 bucket"
}

variable "log_bucket_fqdn" {
  type        = string
  default     = ""
  description = "Optional fqdn of logging bucket, if not supplied a bucket will be generated."
}

variable "log_force_destroy" {
  type        = bool
  description = "Applies to log bucket created by this module only. If true, all objects will be deleted from the bucket on destroy, so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = false
}

variable "log_standard_transition_days" {
  type        = number
  description = "Number of days to persist in the standard storage tier before moving to the glacier tier"
  default     = 30
}

variable "log_glacier_transition_days" {
  type        = number
  description = "Number of days after which to move the data to the glacier storage tier"
  default     = 60
}

variable "log_expiration_days" {
  type        = number
  description = "Number of days after which to expunge the objects"
  default     = 90
}

variable "forward_query_string" {
  type        = bool
  default     = false
  description = "Forward query strings to the origin that is associated with this cache behavior"
}

variable "forward_headers" {
  description = "Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify `*` to include all headers."
  type        = list(string)
  default     = []
}

variable "forward_cookies" {
  type        = string
  description = "Specifies whether you want CloudFront to forward cookies to the origin. Valid options are all, none or whitelist"
  default     = "none"
}

variable "forward_cookies_whitelisted_names" {
  type        = list(string)
  description = "List of forwarded cookie names"
  default     = []
}

variable "price_class" {
  type        = string
  default     = "PriceClass_100"
  description = "Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100`"
}

variable "viewer_minimum_protocol_version" {
  type        = string
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. This is ignored if the default CloudFront certificate is used."
  default     = "TLSv1.2_2021"
}

variable "viewer_protocol_policy" {
  type        = string
  description = "allow-all, redirect-to-https"
  default     = "redirect-to-https"
}

variable "allowed_methods" {
  type        = list(string)
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  description = "List of allowed methods (e.g. ` GET, PUT, POST, DELETE, HEAD`) for AWS CloudFront"
}

variable "cached_methods" {
  type        = list(string)
  default     = ["GET", "HEAD"]
  description = "List of cached methods (e.g. ` GET, PUT, POST, DELETE, HEAD`)"
}

variable "cache_policy_id" {
  type        = string
  default     = null
  description = "ID of the cache policy attached to the cache behavior"
}

variable "origin_request_policy_id" {
  type        = string
  default     = null
  description = "ID of the origin request policy attached to the cache behavior"
}

variable "response_headers_policy_id" {
  type        = string
  description = "The identifier for a response headers policy"
  default     = ""
}

variable "default_ttl" {
  type        = number
  default     = 60
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "min_ttl" {
  type        = number
  default     = 0
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "max_ttl" {
  type        = number
  default     = 31536000
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "geo_restriction_type" {
  # e.g. "whitelist"
  type        = string
  default     = "none"
  description = "Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist`"
}

variable "geo_restriction_locations" {
  type = list(string)

  # e.g. ["US", "CA", "GB", "DE"]
  default     = []
  description = "List of country codes for which CloudFront either to distribute content (whitelist) or not distribute your content (blacklist)"
}

variable "parent_zone_id" {
  type        = string
  default     = ""
  description = "ID of the hosted zone to contain this record (or specify `parent_zone_name`)"
}

variable "parent_zone_name" {
  type        = string
  default     = ""
  description = "Name of the hosted zone to contain this record (or specify `parent_zone_id`)"
}

variable "ordered_cache" {
  type = list(object({
    target_origin_id = string
    path_pattern     = string

    allowed_methods          = optional(list(string), ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"])
    cached_methods           = optional(list(string), ["GET", "HEAD"])
    cache_policy_id          = optional(string, null)
    origin_request_policy_id = optional(string, null)
    compress                 = optional(bool, false)

    viewer_protocol_policy = optional(string, "redirect-to-https")
    min_ttl                = optional(number, 0)
    default_ttl            = optional(number, 60)
    max_ttl                = optional(number, 31536000)

    forward_query_string              = optional(bool, false)
    forward_header_values             = optional(list(string), [])
    forward_cookies                   = optional(string, "none")
    forward_cookies_whitelisted_names = optional(list(string), [])

    response_headers_policy_id = optional(string, "")

    grpc_config = optional(object({
      enabled = bool
    }), { enabled = false })

    lambda_function_association = optional(list(object({
      event_type   = string
      include_body = optional(bool, false)
      lambda_arn   = string
    })), [])

    function_association = optional(list(object({
      event_type   = string
      function_arn = string
    })), [])
  }))
  default     = []
  description = <<DESCRIPTION
An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0.
The fields can be described by the other variables in this file. For example, the field 'lambda_function_association' in this object has
a description in var.lambda_function_association variable earlier in this file. The only difference is that fields on this object are in ordered caches, whereas the rest
of the vars in this file apply only to the default cache. Put value `""` on field `target_origin_id` to specify default s3 bucket origin.
DESCRIPTION
}

variable "custom_origins" {
  type = list(object({
    domain_name                 = string
    origin_id                   = string
    origin_path                 = optional(string, "")
    origin_access_control_id    = optional(string, null)
    response_completion_timeout = optional(number, 0)
    custom_headers = optional(list(object({
      name  = string
      value = string
    })), [])
    custom_origin_config = optional(object({
      http_port                = optional(number, 80)
      https_port               = optional(number, 443)
      origin_protocol_policy   = optional(string, "match-viewer")
      origin_ssl_protocols     = optional(list(string), ["TLSv1", "TLSv1.1", "TLSv1.2"])
      origin_keepalive_timeout = optional(number, 5)
      origin_read_timeout      = optional(number, 30)
    }), null)
    s3_origin_config = optional(object({
      origin_access_identity = string
    }), null)
    origin_shield = optional(object({
      enabled = optional(bool, false)
      region  = optional(string, null)
    }), null)
  }))
  default     = []
  description = "One or more custom origins for this distribution (multiples allowed). See documentation for configuration options description https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html#origin-arguments"
}

variable "trusted_signers" {
  type        = list(string)
  default     = []
  description = "List of AWS account IDs (or self) that you want to allow to create signed URLs for private content"
}

variable "lambda_function_association" {
  type = list(object({
    event_type   = string
    include_body = optional(bool, false)
    lambda_arn   = string
  }))

  description = "A config block that triggers a Lambda@Edge function with specific actions"
  default     = []
}

variable "function_association" {
  type = list(object({
    event_type   = string
    function_arn = string
  }))

  description = <<-EOT
    A config block that triggers a CloudFront function with specific actions.
    See the [aws_cloudfront_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#function-association)
    documentation for more information.
  EOT
  default     = []
}

variable "realtime_log_config_arn" {
  type        = string
  default     = null
  description = "The ARN of the real-time log configuration that is attached to this cache behavior"
}

variable "http_version" {
  type        = string
  default     = "http2"
  description = "The maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3 and http3."
}

variable "grpc_config" {
  type = object({
    enabled = bool
  })
  default     = { enabled = false }
  description = "The gRPC configuration for the default CloudFront distribution cache behavior"
}

variable "origin_type" {
  type        = string
  description = "The type of origin configuration to use. Valid values are 'custom' or 's3'."
  default     = "custom"
  validation {
    condition     = contains(["custom", "s3"], var.origin_type)
    error_message = "Valid values for origin_type are 'custom' or 's3'."
  }
}

variable "s3_origin_config" {
  type = object({
    origin_access_identity = string
  })
  description = "Optional configuration for an S3 origin."
  default     = null
}
