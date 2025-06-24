# Input variables for security group configuration
variable "sg_name"{
    type= string
    description = "security group name"
    default = "security_group"
}
variable "sg_desc"{
    type= string
    description = "security group for roboshop project"
    default = "security group for roboshop project"
}
variable "environment"{
    type = string
    default = "dev"
}
variable "project"{
    type = string
    default = "roboshop"
}
variable "sg_tags"{
    type = map(string)
    default= {
        sg_tags = "roboshop-dev-security-groups"
    }
}