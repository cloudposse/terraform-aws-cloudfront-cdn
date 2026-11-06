enabled = true

region = "us-east-2"

namespace = "eg"

stage = "test"

name = "cdn"

dns_aliases_enabled = false

aliases = []

origin_domain_name = "example.com"

parent_zone_name = "testing.cloudposse.co"

http_version = "http2and3"

availability_zones = ["us-east-2a", "us-east-2b"]

vpc_cidr_block = "172.16.0.0/16"
