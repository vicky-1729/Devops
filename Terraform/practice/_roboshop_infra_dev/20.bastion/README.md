# Bastion Host Configuration

This Terraform configuration creates a bastion host (jump server) for secure access to private resources in the roboshop VPC.

## Overview

The bastion host is deployed in a public subnet and provides secure SSH access to resources in private subnets. It uses security groups from the previous configuration steps.

## Prerequisites

1. VPC and Security Groups must be deployed first
2. AWS credentials configured
3. Terraform installed

## Files

- `main.tf` - Main bastion host resource configuration
- `variables.tf` - Input variable definitions
- `data.tf` - Data sources for AMI and SSM parameters
- `local.tf` - Local values and common tags
- `outputs.tf` - Output values
- `provider.tf` - Provider and Terraform configuration

## Usage

1. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Update `terraform.tfvars` with your values:
   ```hcl
   project     = "roboshop"
   environment = "dev"
   instance_type = "t3.micro"
   key_name     = "your-key-pair-name"
   ```

3. Initialize and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Dependencies

This configuration depends on:
- VPC resources (via SSM parameters)
- Security Group for bastion (via SSM parameter: `/${project}/${environment}/bastion_sg_id`)
- Public subnet IDs (via SSM parameter: `/${project}/${environment}/public_subnet_ids`)

## Outputs

- `bastion_instance_id` - EC2 instance ID
- `bastion_public_ip` - Public IP address for SSH access
- `bastion_private_ip` - Private IP address
- `bastion_public_dns` - Public DNS name
- `bastion_availability_zone` - AZ where instance is deployed

## SSH Access

Once deployed, you can SSH to the bastion host:

```bash
ssh -i your-key.pem ec2-user@<bastion_public_ip>
```

From the bastion host, you can then access private resources:

```bash
ssh -i your-key.pem ec2-user@<private_instance_ip>
```

## Security

- The bastion host is deployed in a public subnet but uses security groups to restrict access
- Only SSH (port 22) access should be allowed from trusted IP ranges
- Use key-based authentication only
- Consider using AWS Session Manager for additional security
