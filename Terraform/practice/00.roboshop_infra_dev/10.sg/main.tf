
# Creates security group using reusable module from GitHub
module "frontend_sg" {
    source = "git::https://github.com/vicky-1729/Devops.git//Terraform/practice/12.modules/aws_sg?ref=main"
    
    # Passing required input variables
    project = var.project
    environment = var.environment
    vpc_id = local.vpc_id
    sg_name = var.frontend_sg_name
    sg_desc = var.frontend_sg_desc
   
}
# Creating the bastion security group
module "bastion_sg" {
    source = "git::https://github.com/vicky-1729/Devops.git//Terraform/practice/12.modules/aws_sg?ref=main"

    # Passing required input variables
    project = var.project
    environment = var.environment
    vpc_id = local.vpc_id
    sg_name = var.bastion_sg_name
    sg_desc = var.bastion_sg_desc
    
}
# Allow connection to bastion using SSH on port 22
resource "aws_security_group_rule" "bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
}
# Creating the private load balancer ALB security group
module "backend_alb_sg" {
  source = "git::https://github.com/vicky-1729/Devops.git//Terraform/practice/12.modules/aws_sg?ref=main"
  # Passing required input variables
  project     = var.project
  environment = var.environment
  vpc_id      = local.vpc_id
  sg_name     = var.backend_alb_sg_name
  sg_desc     = var.backend_alb_sg_desc
}
# Allow connection on port 80 (HTTP) for internal connection due to private ALB
resource "aws_security_group_rule" "backend_alb_bastion" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.sg_id    # Source via proxy sg_id 
  security_group_id        = module.backend_alb_sg.sg_id # Destination
}
