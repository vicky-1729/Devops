locals{
   ami_id =data.aws_ami.joindevops.id
   public_subnet_id =  data.aws_ssm_parameter.public_subnet_ids
   bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id
   common_tags = {
        project = "roboshop"
        environment = "dev"
        terraform =true
   }
}
