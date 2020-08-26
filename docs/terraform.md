## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acm\_certificate\_arn | Existing ACM Certificate ARN | `string` | `""` | no |
| aliases | List of aliases. CAUTION! Names MUSTN'T contain trailing `.` | `list(string)` | `[]` | no |
| allowed\_methods | List of allowed methods (e.g. ` GET, PUT, POST, DELETE, HEAD`) for AWS CloudFront | `list(string)` | <pre>[<br>  "DELETE",<br>  "GET",<br>  "HEAD",<br>  "OPTIONS",<br>  "PATCH",<br>  "POST",<br>  "PUT"<br>]</pre> | no |
| attributes | Additional attributes (e.g. `policy` or `role`) | `list(string)` | `[]` | no |
| cache\_behavior | An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0. | `list(string)` | `[]` | no |
| cached\_methods | List of cached methods (e.g. ` GET, PUT, POST, DELETE, HEAD`) | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD"<br>]</pre> | no |
| comment | Comment for the origin access identity | `string` | `"Managed by Terraform"` | no |
| compress | (Optional) Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false) | `string` | `"false"` | no |
| custom\_error\_response | (Optional) - List of one or more custom error response element maps | `list(string)` | `[]` | no |
| default\_root\_object | Object that CloudFront return when requests the root URL | `string` | `"index.html"` | no |
| default\_ttl | Default amount of time (in seconds) that an object is in a CloudFront cache | `string` | `"60"` | no |
| delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | `"-"` | no |
| dns\_aliases\_enabled | Set to false to prevent dns records for aliases from being created | `string` | `"true"` | no |
| enabled | Set to false to prevent the module from creating any resources | `string` | `"true"` | no |
| forward\_cookies | Specifies whether you want CloudFront to forward cookies to the origin. Valid options are all, none or whitelist | `string` | `"none"` | no |
| forward\_cookies\_whitelisted\_names | List of forwarded cookie names | `list(string)` | `[]` | no |
| forward\_headers | Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify `*` to include all headers. | `list(string)` | `[]` | no |
| forward\_query\_string | Forward query strings to the origin that is associated with this cache behavior | `string` | `"false"` | no |
| geo\_restriction\_locations | List of country codes for which CloudFront either to distribute content (whitelist) or not distribute your content (blacklist) | `list(string)` | `[]` | no |
| geo\_restriction\_type | Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist` | `string` | `"none"` | no |
| is\_ipv6\_enabled | State of CloudFront IPv6 | `string` | `"true"` | no |
| log\_expiration\_days | Number of days after which to expunge the objects | `string` | `"90"` | no |
| log\_glacier\_transition\_days | Number of days after which to move the data to the glacier storage tier | `string` | `"60"` | no |
| log\_include\_cookies | Include cookies in access logs | `string` | `"false"` | no |
| log\_prefix | Path of logs in S3 bucket | `string` | `""` | no |
| log\_standard\_transition\_days | Number of days to persist in the standard storage tier before moving to the glacier tier | `string` | `"30"` | no |
| max\_ttl | Maximum amount of time (in seconds) that an object is in a CloudFront cache | `string` | `"31536000"` | no |
| min\_ttl | Minimum amount of time that you want objects to stay in CloudFront caches | `string` | `"0"` | no |
| name | Name  (e.g. `bastion` or `db`) | `any` | n/a | yes |
| namespace | Namespace (e.g. `cp` or `cloudposse`) | `any` | n/a | yes |
| origin\_domain\_name | (Required) - The DNS domain name of your custom origin (e.g. website) | `string` | `""` | no |
| origin\_http\_port | (Required) - The HTTP port the custom origin listens on | `string` | `"80"` | no |
| origin\_https\_port | (Required) - The HTTPS port the custom origin listens on | `string` | `"443"` | no |
| origin\_keepalive\_timeout | (Optional) The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase. | `string` | `"60"` | no |
| origin\_path | (Optional) - An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin | `string` | `""` | no |
| origin\_protocol\_policy | (Required) - The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer | `string` | `"match-viewer"` | no |
| origin\_read\_timeout | (Optional) The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase. | `string` | `"60"` | no |
| origin\_ssl\_protocols | (Required) - The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS | `list(string)` | <pre>[<br>  "TLSv1",<br>  "TLSv1.1",<br>  "TLSv1.2"<br>]</pre> | no |
| parent\_zone\_id | ID of the hosted zone to contain this record (or specify `parent_zone_name`) | `string` | `""` | no |
| parent\_zone\_name | Name of the hosted zone to contain this record (or specify `parent_zone_id`) | `string` | `""` | no |
| price\_class | Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100` | `string` | `"PriceClass_100"` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | `any` | n/a | yes |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')`) | `map(string)` | `{}` | no |
| viewer\_minimum\_protocol\_version | (Optional) The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. | `string` | `"TLSv1"` | no |
| viewer\_protocol\_policy | allow-all, redirect-to-https | `string` | `"redirect-to-https"` | no |
| web\_acl\_id | (Optional) - Web ACL ID that can be attached to the Cloudfront distribution | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| cf\_aliases | Extra CNAMEs of AWS CloudFront |
| cf\_arn | ID of AWS CloudFront distribution |
| cf\_domain\_name | Domain name corresponding to the distribution |
| cf\_etag | Current version of the distribution's information |
| cf\_hosted\_zone\_id | CloudFront Route 53 zone ID |
| cf\_id | ID of AWS CloudFront distribution |
| cf\_origin\_access\_identity | A shortcut to the full path for the origin access identity to use in CloudFront |
| cf\_status | Current status of the distribution |

