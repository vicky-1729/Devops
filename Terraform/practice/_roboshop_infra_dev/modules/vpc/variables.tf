# VPC Configuration Variables
variable "cidr_blocks" {
    type        = string
    description = "CIDR block for the VPC (e.g., 10.0.0.0/16)"
}

# Subnet CIDR Configuration
variable "public_subnet_cidrs" {
    type        = list(string)
    description = "List of CIDR blocks for public subnets"
}

variable "private_subnet_cidrs" {
    type        = list(string)
    description = "List of CIDR blocks for private subnets"
}

variable "db_subnet_cidrs" {
    type        = list(string)
    description = "List of CIDR blocks for database subnets"
}

# Project and Environment Variables
variable "project" {
    type        = string
    description = "Project name for resource naming and tagging"
}

variable "environment" {
    type        = string
    description = "Environment name (dev, staging, prod)"
}

# Optional Tags Variables
variable "vpc_tags" {
    type        = map(string)
    description = "Additional tags for VPC"
    default     = {}
}

variable "igw_tags" {
    type        = map(string)
    description = "Additional tags for Internet Gateway"
    default     = {}
}

variable "eip_tags" {
    type        = map(string)
    description = "Additional tags for Elastic IP"
    default     = {}
}
variable "public_tags"{
    type = map(string) #it is mandotroy
    default={} # now it is optional
}
variable "private_tags"{
    type = map(string) #it is mandotroy
    default={} # now it is optional
}
variable "db_tags"{
    type = map(string) #it is mandotroy
    default={} # now it is optional
}