terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.59.0"
    }
  }
}

provider "aws" {
  profile = "vscode-personal"
  region  = "us-east-1"

  default_tags {
    tags = {
      managed_by    = "Terraform managed resource"
      project       = "EKS-Terraform"
    }
  }
}
