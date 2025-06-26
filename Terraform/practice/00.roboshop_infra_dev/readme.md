# RoboShop Infrastructure - Development Environment

## 📋 Project Overview
- **Purpose**: Complete infrastructure setup for RoboShop e-commerce application
- **Environment**: Development (dev)
- **Cloud Provider**: Amazon Web Services (AWS)
- **Infrastructure as Code**: Terraform
- **Architecture**: Multi-tier application with VPC, security groups, and bastion host

## 🏗️ Infrastructure Components

### 1. **VPC (Virtual Private Cloud)**
- **Location**: `00.vpc/`
- **Purpose**: Network isolation and foundation
- **Components**:
  - Public and private subnets
  - Internet Gateway
  - NAT Gateway
  - Route tables
  - SSM parameters for resource sharing

### 2. **Security Groups**
- **Location**: `10.sg/`
- **Purpose**: Network access control and firewall rules
- **Components**:
  - Frontend security group
  - Bastion security group  
  - Backend ALB security group
  - Ingress/egress rules

### 3. **Bastion Host**
- **Location**: `20.bastion/`
- **Purpose**: Secure access to private resources
- **Components**:
  - EC2 instance in public subnet
  - SSH key pair
  - Security group with SSH access

## 📁 Directory Structure

```
00.roboshop_infra_dev/
├── readme.md                 # This documentation
├── 00.vpc/                   # VPC infrastructure
│   ├── main.tf              # VPC, subnets, gateways
│   ├── provider.tf          # AWS provider configuration
│   ├── ssm_parameter.tf     # Parameter store values
│   └── variables.tf         # Input variables
├── 10.sg/                    # Security groups
│   ├── datasource.tf        # Data sources (VPC info)
│   ├── local.tf             # Local values
│   ├── main.tf              # Security group resources
│   ├── provider.tf          # AWS provider
│   ├── ssm_parameter.tf     # Output parameters
│   └── variable.tf          # Variables
└── 20.bastion/               # Bastion host
    ├── datasource.tf         # AMI and VPC data
    ├── locals.tf             # Local computations
    ├── main.tf               # EC2 instance
    ├── outputs.tf            # Output values
    ├── provider.tf           # AWS provider
    └── varibales.tf          # Input variables
```

## 🚀 Deployment Order

### **Step 1: VPC Setup**
```bash
cd 00.vpc/
terraform init
terraform plan
terraform apply
```
- Creates foundational network infrastructure
- Establishes subnets and routing
- Stores VPC details in SSM Parameter Store

### **Step 2: Security Groups**
```bash
cd ../10.sg/
terraform init
terraform plan
terraform apply
```
- Creates security groups for different tiers
- Configures firewall rules
- References VPC from Step 1

### **Step 3: Bastion Host**
```bash
cd ../20.bastion/
terraform init
terraform plan
terraform apply
```
- Deploys jump server for secure access
- Uses security groups from Step 2
- Provides SSH access to private resources

## 🔧 Key Features

### **Modular Design**
- Uses reusable Terraform modules from GitHub
- Separation of concerns (VPC, Security, Compute)
- Environment-specific configurations

### **Security Best Practices**
- Private subnets for application servers
- Bastion host for secure SSH access
- Least privilege security group rules
- No direct internet access to private resources

### **Resource Management**
- SSM Parameter Store for sharing data between modules
- Consistent naming conventions
- Environment and project tagging

## 📋 Prerequisites

### **Tools Required**
- Terraform >= 1.0
- AWS CLI configured
- Valid AWS credentials
- SSH key pair for bastion access

### **AWS Permissions**
- EC2 full access
- VPC management
- SSM Parameter Store access
- IAM role creation (if needed)

## 🔑 Variables Configuration

### **Common Variables**
- `project`: Project name (e.g., "roboshop")
- `environment`: Environment name (e.g., "dev")
- `region`: AWS region for deployment

### **VPC Variables**
- CIDR blocks for VPC and subnets
- Availability zones
- Gateway configurations

### **Security Group Variables**
- Security group names and descriptions
- Port configurations
- Source/destination rules

## 📊 Outputs

### **VPC Outputs**
- VPC ID stored in SSM
- Subnet IDs for public/private
- Route table references

### **Security Group Outputs**
- Security group IDs
- Rule configurations
- Cross-references for other modules

### **Bastion Outputs**
- Instance ID and public IP
- SSH connection details
- Security group associations

## 🛠️ Troubleshooting

### **Common Issues**
- **Dependencies**: Ensure modules are applied in correct order
- **Permissions**: Verify AWS credentials and permissions
- **Variables**: Check all required variables are provided
- **State**: Manage Terraform state files properly

### **Validation Commands**
```bash
terraform validate    # Check syntax
terraform fmt         # Format code
terraform plan        # Preview changes
```

## 📝 Notes

### **Important Considerations**
- Always run `terraform plan` before `apply`
- Keep state files secure and backed up
- Use workspaces for multiple environments
- Review security group rules regularly

### **Future Enhancements**
- Add application load balancers
- Implement auto-scaling groups
- Add RDS database configuration
- Configure monitoring and logging

---

**Author**: DevOps Team  
**Last Updated**: June 2025  
**Version**: 1.0