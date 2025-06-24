locals {
   
    data "aws_ami" "joindevops" {
    owners           = ["973714476881"]
    most_recent      = true

    filter {
        name   = "name"
        values = ["RHEL-9-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    }

    bastion_sg_id= data.aws_ssm_parameter.bastion_sg_id
    
    common_tags={
        project = "roboshop"
        environment = "dev"
        terraform = true
    }
}

