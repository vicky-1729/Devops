# AWS provider config and S3 backend for state storage
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.98.0"
    }
  }
  backend "s3" {  
    bucket       = "vs-roboshop-infra-dev"  
    key          = "roboshop-infra-dev-sg"  
    region       = "us-east-1"  
    encrypt      = true  
    use_lockfile = true  #S3 native locking
  }  
}

provider "aws"{
    region = "us-east-1"
}