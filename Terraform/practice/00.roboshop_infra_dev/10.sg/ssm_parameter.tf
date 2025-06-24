resource "aws_ssm_parameter" "sg_id" {
  name  = "/${var.project}/${var.environment}/sg_id"
  type  = "String"
  value = module.sg.sg_id
}

output "sg_id" {
  value       = module.sg.sg_id
  description = "ID of the security group"
}