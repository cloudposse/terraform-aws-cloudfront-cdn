## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| acm_certificate_arn | Existing ACM Certificate ARN | string | `` | no |
| aliases | List of aliases. CAUTION! Names MUSTN'T contain trailing `.` | list | `<list>` | no |
| allowed_methods | List of allowed methods (e.g. ` GET, PUT, POST, DELETE, HEAD`) for AWS CloudFront | list | `<list>` | no |
| attributes | Additional attributes (e.g. `policy` or `role`) | list | `<list>` | no |
| cache_behavior | An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0. | list | `<list>` | no |
| cached_methods | List of cached methods (e.g. ` GET, PUT, POST, DELETE, HEAD`) | list | `<list>` | no |
| comment | Comment for the origin access identity | string | `Managed by Terraform` | no |
| compress | (Optional) Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false) | string | `false` | no |
| custom_error_response | (Optional) - List of one or more custom error response element maps | list | `<list>` | no |
| default_root_object | Object that CloudFront return when requests the root URL | string | `index.html` | no |
| default_ttl | Default amount of time (in seconds) that an object is in a CloudFront cache | string | `60` | no |
| delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | string | `-` | no |
| dns_aliases_enabled | Set to false to prevent dns records for aliases from being created | string | `true` | no |
| enabled | Set to false to prevent the module from creating any resources | string | `true` | no |
| forward_cookies | Specifies whether you want CloudFront to forward cookies to the origin. Valid options are all, none or whitelist | string | `none` | no |
| forward_cookies_whitelisted_names | List of forwarded cookie names | list | `<list>` | no |
| forward_headers | Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify `*` to include all headers. | list | `<list>` | no |
| forward_query_string | Forward query strings to the origin that is associated with this cache behavior | string | `false` | no |
| geo_restriction_locations | List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist) | list | `<list>` | no |
| geo_restriction_type | Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist` | string | `none` | no |
| is_ipv6_enabled | State of CloudFront IPv6 | string | `true` | no |
| log_expiration_days | Number of days after which to expunge the objects | string | `90` | no |
| log_glacier_transition_days | Number of days after which to move the data to the glacier storage tier | string | `60` | no |
| log_include_cookies | Include cookies in access logs | string | `false` | no |
| log_prefix | Path of logs in S3 bucket | string | `` | no |
| log_standard_transition_days | Number of days to persist in the standard storage tier before moving to the glacier tier | string | `30` | no |
| max_ttl | Maximum amount of time (in seconds) that an object is in a CloudFront cache | string | `31536000` | no |
| min_ttl | Minimum amount of time that you want objects to stay in CloudFront caches | string | `0` | no |
| name | Name  (e.g. `bastion` or `db`) | string | - | yes |
| namespace | Namespace (e.g. `cp` or `cloudposse`) | string | - | yes |
| origin_domain_name | (Required) - The DNS domain name of your custom origin (e.g. website) | string | `` | no |
| origin_http_port | (Required) - The HTTP port the custom origin listens on | string | `80` | no |
| origin_https_port | (Required) - The HTTPS port the custom origin listens on | string | `443` | no |
| origin_keepalive_timeout | (Optional) The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase. | string | `60` | no |
| origin_path | (Optional) - An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin | string | `` | no |
| origin_protocol_policy | (Required) - The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer | string | `match-viewer` | no |
| origin_read_timeout | (Optional) The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase. | string | `60` | no |
| origin_ssl_protocols | (Required) - The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS | list | `<list>` | no |
| parent_zone_id | ID of the hosted zone to contain this record  (or specify `parent_zone_name`) | string | `` | no |
| parent_zone_name | Name of the hosted zone to contain this record (or specify `parent_zone_id`) | string | `` | no |
| price_class | Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100` | string | `PriceClass_100` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | - | yes |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')`) | map | `<map>` | no |
| viewer_minimum_protocol_version | (Optional) The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. | string | `TLSv1` | no |
| viewer_protocol_policy | allow-all, redirect-to-https | string | `redirect-to-https` | no |
| web_acl_id | (Optional) - Web ACL ID that can be attached to the Cloudfront distribution | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| cf_aliases | Extra CNAMEs of AWS CloudFront |
| cf_arn | ID of AWS CloudFront distribution |
| cf_domain_name | Domain name corresponding to the distribution |
| cf_etag | Current version of the distribution's information |
| cf_hosted_zone_id | CloudFront Route 53 zone ID |
| cf_id | ID of AWS CloudFront distribution |
| cf_origin_access_identity | A shortcut to the full path for the origin access identity to use in CloudFront |
| cf_status | Current status of the distribution |

