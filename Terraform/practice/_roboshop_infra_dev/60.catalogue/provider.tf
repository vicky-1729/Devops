terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Terraform backend configuration
terraform {
  backend "s3" {
    bucket = "roboshop-terraform-state-bucket"
    key    = "catalogue/terraform.tfstate"
    region = "us-east-1"
  }
}
