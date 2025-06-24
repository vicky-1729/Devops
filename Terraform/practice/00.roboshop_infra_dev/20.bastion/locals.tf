locals {
    aws_ami = data.aws_ami.joindevops.id
    bastion_sg_id= [data.aws_ssm_parameter.bastion_sg_id.value]
    
    common_tags={
        project = "roboshop"
        environment = "dev"
        terraform = true
    }
}

