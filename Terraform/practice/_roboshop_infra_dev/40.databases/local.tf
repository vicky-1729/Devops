locals {
    ami_id           = data.aws_ami.joindevops.id
    vpc_sg_id       = data.aws_ssm_parameter.vpc_sg_id
    database_subnet_id = split(",", data.aws_ssm_parameter.database_subnet_ids.value)[0]
     common_tags = {
        project = var.project
        environment = var.environment
        terraform = true
    }

}