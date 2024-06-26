terraform {
  required_version = ">= 1.4"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}
