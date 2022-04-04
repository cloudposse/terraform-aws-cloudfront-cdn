terraform {
  required_version = ">= 0.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0, < 4"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.2"
    }
  }
}
