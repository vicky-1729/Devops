# Security Groups Configuration

This Terraform configuration creates security groups for the roboshop application infrastructure.

## Overview

Creates the following security groups:
- **Frontend SG**: For frontend web servers
- **Bastion SG**: For bastion/jump host
- **Backend ALB SG**: For backend application load balancer

## Prerequisites

1. VPC must be deployed first (VPC ID is retrieved from SSM parameter)
2. AWS credentials configured
3. Terraform installed

## Files

- `main.tf` - Main security group module calls and rules
- `variables.tf` - Input variable definitions
- `data.tf` - Data sources for VPC ID from SSM
- `locals.tf` - Local values for VPC ID
- `outputs.tf` - Security group ID outputs
- `ssm_parameter.tf` - Stores SG IDs in SSM for other modules
- `provider.tf` - Provider and Terraform configuration

## Usage

1. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Update `terraform.tfvars` with your values if needed

3. Initialize and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Security Rules

- **Frontend**: SSH access from anywhere (port 22)
- **Bastion**: SSH access from anywhere (port 22)
- **Backend ALB**: HTTP access from frontend SG (port 80)

## Dependencies

This configuration depends on:
- VPC resources (via SSM parameter: `/${project}/${environment}/vpc_id`)

## Outputs

- `frontend_sg_id` - Frontend security group ID
- `bastion_sg_id` - Bastion security group ID
- `backend_alb_sg_id` - Backend ALB security group ID

## SSM Parameters Created

- `/${project}/${environment}/frontend_sg_id`
- `/${project}/${environment}/bastion_sg_id`
- `/${project}/${environment}/backend_alb_sg_id`

These parameters are used by other infrastructure modules that need to reference these security groups.
