output "catalogue_asg_name" {
  description = "Name of the catalogue auto scaling group"
  value       = aws_autoscaling_group.catalogue.name
}

output "catalogue_asg_arn" {
  description = "ARN of the catalogue auto scaling group"
  value       = aws_autoscaling_group.catalogue.arn
}

output "catalogue_target_group_arn" {
  description = "ARN of the catalogue target group"
  value       = aws_lb_target_group.catalogue.arn
}

output "catalogue_launch_template_id" {
  description = "ID of the catalogue launch template"
  value       = aws_launch_template.catalogue.id
}

output "catalogue_dns_name" {
  description = "DNS name for catalogue service"
  value       = aws_route53_record.catalogue.fqdn
}
