variable "cidr_block"{
    default = "10.0.0.0/16"
}
variable "project"{
    type = string
}
variable "env" {
    type = string
}
variable public_subnet_cidr{
    type = list(string)
    
}
variable private_subnet_cidr{
    type = list(string)
}
variable db_subnet_cidr{
    type = list(string)
}