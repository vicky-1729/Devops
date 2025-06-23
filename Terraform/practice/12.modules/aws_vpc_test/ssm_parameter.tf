resource "aws_ssm_parameter" "vpc_id" {
  name  = "/{module.vpc.project}/{module.dev.env}-vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
}