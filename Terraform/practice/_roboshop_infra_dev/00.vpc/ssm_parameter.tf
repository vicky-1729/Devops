# Store VPC information in SSM Parameter Store for sharing with other modules

# Store VPC ID for reference by other infrastructure modules
resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}/${var.environment}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
  
  tags = {
    Project     = var.project
    Environment = var.environment
    Purpose     = "VPC ID for cross-module reference"
  }
}

# Store public subnet IDs as comma-separated string
resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project}/${var.environment}/public_subnet_ids"
  type  = "StringList"
  value = join(",", module.vpc.public_subnet_ids)
  
  tags = {
    Project     = var.project
    Environment = var.environment
    Purpose     = "Public subnet IDs for load balancers and public resources"
  }
}

# Store private subnet IDs for application servers
resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project}/${var.environment}/private_subnet_ids"
  type  = "StringList"
  value = join(",", module.vpc.private_subnet_ids)
  
  tags = {
    Project     = var.project
    Environment = var.environment
    Purpose     = "Private subnet IDs for application servers"
  }
}

# Store database subnet IDs for RDS and database resources
resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project}/${var.environment}/database_subnet_ids"
  type  = "StringList"
  value = join(",", module.vpc.database_subnet_ids)
  
  tags = {
    Project     = var.project
    Environment = var.environment
    Purpose     = "Database subnet IDs for RDS and database resources"
  }
}
