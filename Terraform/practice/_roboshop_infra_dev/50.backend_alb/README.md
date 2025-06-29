# Backend Application Load Balancer (ALB)

This Terraform configuration creates an internal Application Load Balancer for backend services in the roboshop infrastructure.

## Overview

The backend ALB is deployed in private subnets and provides load balancing for backend application servers. It's configured as an internal load balancer, meaning it's only accessible from within the VPC.

## Prerequisites

1. VPC and subnets must be deployed first
2. Security groups must be created first
3. AWS credentials configured
4. Terraform installed

## Files

- `main.tf` - Main ALB module configuration
- `variables.tf` - Input variable definitions
- `data.tf` - Data sources for SSM parameters
- `local.tf` - Local values and common tags
- `outputs.tf` - ALB information outputs
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

## Configuration

- **Load Balancer Type**: Application Load Balancer (ALB)
- **Scheme**: Internal (private subnets only)
- **Subnets**: Deployed in private subnets
- **Security Group**: Uses existing security group from SSM parameter

## Dependencies

This configuration depends on:
- VPC resources (via SSM parameter: `/${project}/${environment}/vpc_id`)
- Private subnet IDs (via SSM parameter: `/${project}/${environment}/private_subnet_ids`)
- Backend ALB security group (via SSM parameter: `/${project}/${environment}/backend_alb_sg_id`)

## Outputs

- `backend_alb_id` - Load balancer ID
- `backend_alb_arn` - Load balancer ARN
- `backend_alb_dns_name` - DNS name for internal access
- `backend_alb_zone_id` - Route 53 hosted zone ID
- `backend_alb_target_group_arns` - Target group ARNs

## Target Groups

The ALB module creates target groups that can be used by backend services. These target groups can be referenced in your application server configurations to register instances.

## Security

- Internal load balancer (not internet-facing)
- Uses security groups to control access
- Only accessible from within the VPC
- Frontend servers can access via the security group rules
