locals {
   ami_id = data.aws_ami.joindevops.id
   public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
   bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
   common_tags = {
        project = "roboshop"
        environment = "dev"
        terraform = true
   }
}
