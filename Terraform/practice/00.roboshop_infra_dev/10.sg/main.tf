
# Creates security group using reusable module from GitHub
module "sg" {
    source = "git::https://github.com/vicky-1729/Devops.git//Terraform/practice/12.modules/aws_sg?ref=main"
    #passing required input variables
    sg_name = var.sg_name
    sg_desc = var.sg_desc
    vpc_id = local.vpc_id
    environment = var.environment
    project = var.project
    sg_tags= var.sg_tags
}
