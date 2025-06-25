
# Creates security group using reusable module from GitHub
module "frontend_sg" {
    source = "git::https://github.com/vicky-1729/Devops.git//Terraform/practice/12.modules/aws_sg?ref=main"
    
    #passing required input variables
    project = var.project
    environment = var.environment
    vpc_id = local.vpc_id
    sg_name = var.frontend_sg_name
    sg_desc = var.frontend_sg_desc
   
}

module "bastion_sg" {
    source = "git::https://github.com/vicky-1729/Devops.git//Terraform/practice/12.modules/aws_sg?ref=main"

    #passing required input variables
    project = var.project
    environment = var.environment
    vpc_id = local.vpc_id
    sg_name = var.bastion_sg_name
    sg_desc = var.bastion_sg_desc
    
}

resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.sg_id
}