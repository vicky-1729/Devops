

# Project and Environment Variables
variable "project" {
    type        = string
    description = "Project name for resource naming and tagging"
}

variable "environment" {
    type        = string
    description = "Environment name (dev, staging, prod)"
}
