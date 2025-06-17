module "vpc"{
    source = "../aws_vpc"
    #mandorty varibles
    env = "dev"
    project = "roboshop"
}