# Input variables for security group configuration
variable "environment" {
    type        = string
    description = "Environment name (dev, prod, staging)"
    default     = "dev"
}

variable "project" {
    type        = string
    description = "Project name for resource naming and tagging"
    default     = "roboshop"
}

variable "frontend_sg_name" {
    type        = string
    description = "Name for the frontend security group"
    default     = "frontend"
}

variable "frontend_sg_desc" {
    type        = string
    description = "Description for the frontend security group"
    default     = "Security group for RoboShop frontend servers"
}

variable "bastion_sg_name" {
    type        = string
    description = "Name for the bastion host security group"
    default     = "bastion"
}

variable "bastion_sg_desc" {
    type        = string
    description = "Description for the bastion host security group"
    default     = "Security group for RoboShop bastion host"
}

variable "backend_alb_sg_name" {
    type        = string
    description = "Name for the backend ALB security group"
    default     = "backend-alb"
}

variable "backend_alb_sg_desc" {
    type        = string
    description = "Description for the backend ALB security group"
    default     = "Security group for RoboShop backend load balancer"
}
