variable "region" {
  type        = string
  description = "AWS region"
}

variable "origin_domain_name" {
  type        = string
  description = "The DNS domain name of the origin"
  default     = ""
}

variable "logging_enabled" {
  type        = bool
  default     = false
  description = "When true, access logs will be sent to a newly created S3 bucket"
}
