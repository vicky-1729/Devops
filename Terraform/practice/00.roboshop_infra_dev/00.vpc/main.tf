
module "vpc" {
    source = "git::https://github.com/vicky-1729/Devops.git//Terraform/practice/12.modules/aws_vpc?ref=main"
    #passing required input variables
    cidr_block = var.cidr_block
    project = var.project
    env = var.env
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    db_subnet_cidr = var.db_subnet_cidr
    private_tags = var.private_tags
    public_tags = var.public_tags
    db_tags = var.db_tags
    igw_tags = var.igw_tags
}
