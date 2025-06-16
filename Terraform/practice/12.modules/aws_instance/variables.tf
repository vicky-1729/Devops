variable instance_tags{
    type = map
}
variable sg_ids {
    type = list 
}
variable instance_type{
    default = "t2.micro"
}
variable ami{
    default = "ami-09c813fb71547fc4f"
}