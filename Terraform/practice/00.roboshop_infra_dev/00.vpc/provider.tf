terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
  }
  backend "s3" {  
    bucket       = "vs-roboshop-infra-dev"  
    key          = "roboshop-infra-dev""  
    region       = "us-east-1"  
    encrypt      = true  
    use_lockfile = true  #S3 native locking
  }  
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}