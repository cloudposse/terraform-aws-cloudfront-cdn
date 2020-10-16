locals {
  wp_nocache_behavior = {
    viewer_protocol_policy      = "redirect-to-https"
    cached_methods              = ["GET", "HEAD"]
    allowed_methods             = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    default_ttl                 = 60
    min_ttl                     = 0
    max_ttl                     = 86400
    compress                    = true
    target_origin_id            = "wordpress-cloudposse.com"
    forward_cookies             = "all"
    forward_header_values       = ["*"]
    forward_query_string        = true
    lambda_function_association = []
  }
}

module "cdn" {
  source     = "../../"
  name       = "wordpress"
  attributes = ["cloudposse.com"]

  aliases                           = ["cloudposse.com", "www.cloudposse.com"]
  origin_domain_name                = "origin.cloudposse.com"
  origin_protocol_policy            = "match-viewer"
  viewer_protocol_policy            = "redirect-to-https"
  parent_zone_name                  = "cloudposse.com"
  default_root_object               = ""
  acm_certificate_arn               = "xxxxxxxxxxxxxxxxxxx"
  forward_cookies                   = "whitelist"
  forward_cookies_whitelisted_names = ["comment_author_*", "comment_author_email_*", "comment_author_url_*", "wordpress_logged_in_*", "wordpress_test_cookie", "wp-settings-*"]
  forward_headers                   = ["Host", "Origin", "Access-Control-Request-Headers", "Access-Control-Request-Method"]
  forward_query_string              = true
  default_ttl                       = 60
  min_ttl                           = 0
  max_ttl                           = 86400
  compress                          = true
  cached_methods                    = ["GET", "HEAD"]
  allowed_methods                   = ["GET", "HEAD", "OPTIONS"]
  price_class                       = "PriceClass_All"

  ordered_cache = [
    merge(local.wp_nocache_behavior, map("path_pattern", "wp-admin/*")),
    merge(local.wp_nocache_behavior, map("path_pattern", "wp-login.php")),
    merge(local.wp_nocache_behavior, map("path_pattern", "wp-signup.php")),
    merge(local.wp_nocache_behavior, map("path_pattern", "wp-trackback.php")),
    merge(local.wp_nocache_behavior, map("path_pattern", "wp-cron.php")),
    merge(local.wp_nocache_behavior, map("path_pattern", "xmlrpc.php"))
  ]

  context = module.this.context
}
