terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ""
    }
  }
}

provider "aws" {
  profile = "vscode-peronal"
  region  = "us-east-1"
}
