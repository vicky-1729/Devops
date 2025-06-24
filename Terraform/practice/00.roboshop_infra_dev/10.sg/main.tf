
# Creates security group using reusable module from GitHub
module "frontend_sg" {
    source = "git::https://github.com/vicky-1729/Devops.git//Terraform/practice/12.modules/aws_sg?ref=main"
    #passing required input variables
    
    project = var.project
    environment = var.environment
    vpc_id = local.vpc_id
    sg_name = var.frontend_sg_name
    sg_desc = var.frontend_sg_desc
    sg_tags= var.frontend_sg_tags
}