variable "project" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "roboshop"
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "env" {
  description = "Environment name (dev, stage, prod)"
  type        = string
  default     = "dev"
}

variable "public_subnet_cidr" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidr" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "db_subnet_cidr" {
  description = "CIDR blocks for database subnets"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "igw_tags" {
  description = "Additional tags for Internet Gateway"
  type        = map(string)
  default     = {
    Tier = "roboshop-IGW"
  }
}

variable "private_tags" {
  description = "Additional tags for private subnets"
  type        = map(string)
  default     = {
    Tier = "Private"
  }
}

variable "public_tags" {
  description = "Additional tags for public subnets"
  type        = map(string)
  default     = {
    Tier = "Public"
  }
}

variable "db_tags" {
  description = "Additional tags for database subnets"
  type        = map(string)
  default     = {
    Tier = "db"
  }
}