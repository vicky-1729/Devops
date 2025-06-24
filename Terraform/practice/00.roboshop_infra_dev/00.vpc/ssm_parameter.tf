resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}/${var.env}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id

  # Output example: "vpc-0abc123def456789"
  # Creates an SSM parameter with name like "/roboshop/dev-vpc_id"
  # Stores a single string value which is the VPC ID
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project}/${var.env}/public_subnet_ids"
  type  = "StringList"
  value = join(",", module.vpc.public_subnet_ids)

  # Output example: "subnet-0abc123def456789,subnet-0def456789abc1234"
  # Creates an SSM parameter with name like "/roboshop/dev/public_subnet_ids"
  # Stores multiple subnet IDs as a comma-separated list
  # Note: join() is needed to convert the list to a comma-separated string for StringList type
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project}/${var.env}/private_subnet_ids"
  type  = "StringList"
  value = join(",", module.vpc.private_subnet_ids)

  # Output example: "subnet-1abc123def456789,subnet-1def456789abc1234"
  # Creates an SSM parameter with name like "/roboshop/dev/private_subnet_ids"
  # Stores multiple subnet IDs as a comma-separated list
  # Note: join() is needed to convert the list to a comma-separated string for StringList type
}
