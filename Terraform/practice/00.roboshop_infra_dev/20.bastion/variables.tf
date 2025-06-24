variable "instance_type"{
    type = "string"
    default="t3.micro"
}

variable "environment"{
    type = string
    default = "dev"
}
variable "project"{
    type = string
    default = "roboshop"
}
variable "instance_tags"{
    type = map(string)
    default= {
        instance_tags = "roboshop-dev-bastion"
    }