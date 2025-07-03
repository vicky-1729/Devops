# SSM Parameter for Catalogue Target Group ARN
resource "aws_ssm_parameter" "catalogue_target_group_arn" {
  name  = "/${var.project}/${var.environment}/catalogue_target_group_arn"
  type  = "String"
  value = aws_lb_target_group.catalogue.arn
  tags  = local.common_tags
}
