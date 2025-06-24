# Outputs for the bastion host instance
output "bastion_instance_id" {
  description = "ID of the bastion EC2 instance"
  value       = module.bastion.instance_id
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion host"
  value       = module.bastion.public_ip
}

output "bastion_private_ip" {
  description = "Private IP address of the bastion host"
  value       = module.bastion.private_ip
}
