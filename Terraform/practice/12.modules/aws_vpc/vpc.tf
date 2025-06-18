resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = merge(
    local.common_tags,{
        Name="${var.project}-${var.env}"
    }
  )
}
  #IGW creation as roboshop-dev
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id # IGW directly added to the vpc

  tags = merge(
    var.igw_tags,
    local.common_tags,{
        Name = "${var.project}-${var.env}"

  })
}
  #roboshop-dev-public-us-east-1a and 1b 

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index] # create mutliple subnets it will work 
  availability_zone = local.az_zones[count.index]
  map_public_ip_on_launch = "true"
  tags = merge(
    var.public_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.env}-public-${local.az_zones[count.index]}"
    }
  )
}

#roboshop-dev-private-us-east-1a and 1b

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = local.az_zones[count.index]

  tags = merge(
    var.private_tags
   local.common_tags,{
    Name = "${var.project}-${var.env}-private-${local.az_zones[count.index]}"
  })
}

#roboshop-dev-db-us-east-1a and 1b

resource "aws_subnet" "db" {
  count = length(var.db_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.db_subnet_cidr[count.index]
  availability_zone = local.az_zones[count.index]

  tags = merge(
   var.db_tags,
   local.common_tags,{
    Name = "${var.project}-${var.env}-db-${local.az_zones[count.index]}"
  })
}