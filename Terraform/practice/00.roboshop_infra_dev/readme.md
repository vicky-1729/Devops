# RoboShop Infrastructure Development Project

This directory contains the Terraform code for setting up the complete infrastructure for the RoboShop application in a development environment. The infrastructure is organized in a modular approach, with each component managed separately.

## Directory Structure

1. **00.vpc/** - Creates the foundational network infrastructure
   - VPC, subnets (public, private, database)
   - Internet Gateway, NAT Gateway
   - Route tables and security groups
   - Stores resource IDs in SSM Parameter Store

2. **10.sg/** - Creates security groups for various components
   - Frontend security group
   - Bastion host security group
   - Application security groups
   -# RoboShop Infrastructure Development Project

This directory contains the Terraform code for setting up the complete infrastructure for the RoboShop application in a development environment. The infrastructure is organized in a modular