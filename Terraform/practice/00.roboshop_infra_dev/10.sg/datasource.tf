# Fetches VPC ID from Parameter Store for use in security group
data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}
