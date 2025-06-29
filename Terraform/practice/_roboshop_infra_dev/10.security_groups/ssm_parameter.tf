resource "aws_ssm_parameter" "frontend_sg_id" {
  name  = "/${var.project}/${var.environment}/frontend_sg_id"
  type  = "String"
  value = module.frontend.sg_id 
  
  tags = {
    Project     = var.project
    Environment = var.environment
    Purpose     = "Frontend security group ID for cross-module reference"
  }
}
resource "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/${var.project}/${var.environment}/bastion_sg_id"
  type  = "String"
  value = module.bastion.sg_id 
  
  tags = {
    Project     = var.project
    Environment = var.environment
    Purpose     = "Bastion security group ID for cross-module reference"
  }
}
