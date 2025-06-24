variable "sg_name"{
    type = string
}
variable "sg_desc"{
    type = string
}
variable "vpc_id"{
    type = string
}
variable "sg_tags"{
    type = map(string)
    default = {}
}
variable "enviorment"{
    type = string
}
variable "project"{
    type = string
}