# Terraform Block
terraform {
  required_version = ">= 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.46"
    }
  }
}

# Provider Block
provider "aws" {
  region = var.aws_region
}