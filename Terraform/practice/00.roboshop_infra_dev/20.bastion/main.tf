module "bastion"{
    source = "git::https://github.com/vicky-1729/Devops.git//Terraform/practice/12.modules/aws_instance?ref=main"

    # pass inputs
    ami = local.aws_ami
    instance_type = var.instance_type
    sg_ids = local.bastion_sg_id
    subnet_id = local.public_subnet_id
    
    instance_tags = merge(
        var.instance_tags,
        local.common_tags,{
            Name = "${var.project}-${var.environment}-bastion"
        }
        )
}