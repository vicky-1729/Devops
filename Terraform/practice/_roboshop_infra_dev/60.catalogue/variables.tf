variable "project" {
  description = "Project name"
  type        = string
  default     = "roboshop"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type for catalogue service"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "roboshop-key"
}

variable "zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "zone_name" {
  description = "Route53 zone name"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances in auto scaling group"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Maximum number of instances in auto scaling group"
  type        = number
  default     = 4
}

variable "min_capacity" {
  description = "Minimum number of instances in auto scaling group"
  type        = number
  default     = 1
}
