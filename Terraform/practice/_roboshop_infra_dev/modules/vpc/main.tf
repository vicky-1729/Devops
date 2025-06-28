# Create VPC with DNS hostnames enabled
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_blocks
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = merge(
    local.common_tags,
    var.vpc_tags,
    {
      # roboshop-dev-vpc
      Name = "${var.project}-${var.environment}-vpc"
    }
  )
}

# Create Internet Gateway for VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    var.igw_tags,
    {
      # roboshop-dev-igw
      Name = "${var.project}-${var.environment}-igw"
    }
  )
}

# Create public subnets in VPC
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = local.availability_zones[count.index]
  map_public_ip_on_launch = true
  
  tags = merge(
    local.common_tags,
    {
      # roboshop-dev-public-us-east-1a
      Name = "${var.project}-${var.environment}-public-${local.availability_zones[count.index]}"
    }
  )
}

# Create private subnets in VPC
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]
  
  tags = merge(
    local.common_tags,
    {
      # roboshop-dev-private-us-east-1a
      Name = "${var.project}-${var.environment}-private-${local.availability_zones[count.index]}"
    }
  )
}

# Create database subnets in VPC
resource "aws_subnet" "database" {
  count             = length(var.db_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]
  
  tags = merge(
    local.common_tags,
    {
      # roboshop-dev-database-us-east-1a
      Name = "${var.project}-${var.environment}-database-${local.availability_zones[count.index]}"
    }
  )
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "eip" {
  domain = "vpc"
  tags = merge(
    var.eip_tags,
    local.common_tags,
    {
      # roboshop-dev-nat-eip
      Name = "${var.project}-${var.environment}-eip"
    }
  )
}