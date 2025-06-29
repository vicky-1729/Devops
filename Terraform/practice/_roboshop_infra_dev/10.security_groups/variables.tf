# Project and Environment Variables
variable "project" {
    type        = string
    description = "Project name for resource naming and tagging"
    default = "roboshop"
}

variable "environment" {
    type        = string
    description = "Environment name (dev, staging, prod)"
    default = "dev"
}

# Security Group Configuration Variables
variable "frontend_sg_name" {
    type        = string
    description = "Name for the security group"
    default = "frontend_sg"
}

variable "frontend_sg_desc" {
    type        = string
    description = "Description for the security group"
    default = "frontend security group"
}
# Security Group Configuration Variables
variable "bastion_sg_name" {
    type        = string
    description = "Name for the security group"
    default = "bastion_sg"
}

variable "bastion_sg_desc" {
    type        = string
    description = "Description for the security group"
    default = "bastion security group"
}



