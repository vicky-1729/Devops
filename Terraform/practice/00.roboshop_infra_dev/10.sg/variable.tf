# Input variables for security group configuration
variable "frontend_sg_name"{
    type= string
    description = "security group name"
    default = "frontend_security_group"
}
variable "frontend_sg_desc"{
    type= string
    description = "security group for roboshop project"
    default = "security group for roboshop project frontend"
}
variable "environment"{
    type = string
    default = "dev"
}
variable "project"{
    type = string
    default = "roboshop"
}
variable "frontend_sg_tags"{
    type = map(string)
    default= {
        sg_tags = "roboshop-dev-frontend"
    }
}



# Input variables for security group configuration
variable "bastion_sg_name"{
    type= string
    description = "security group name"
    default = "bastion_security_group"
}
variable "bastion_sg_desc"{
    type= string
    description = "security group for roboshop project"
    default = "security group for roboshop project bastion"
}

variable "bastion_sg_tags"{
    type = map(string)
    default= {
        sg_tags = "roboshop-dev-bastion"
    }
}