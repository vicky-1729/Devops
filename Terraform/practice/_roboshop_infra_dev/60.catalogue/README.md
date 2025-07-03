# Catalogue Service Module

## Overview
This module deploys the Catalogue microservice for the RoboShop e-commerce application. The service is deployed using AWS Auto Scaling Groups with Application Load Balancer integration for high availability and scalability.

## Architecture

### Components
- **Launch Template**: Defines EC2 instance configuration for catalogue service
- **Auto Scaling Group**: Manages service instances with automatic scaling
- **Target Group**: Integrates with backend ALB for load balancing
- **Route53 Record**: DNS entry for service discovery
- **CloudWatch Alarms**: Monitors CPU utilization for auto-scaling decisions

### Service Configuration
- **Runtime**: Node.js 18.x
- **Port**: 8080
- **Database**: MongoDB connection
- **Health Check**: `/health` endpoint
- **Scaling**: CPU-based auto-scaling

## Resources Created

### 1. Launch Template
```hcl
resource "aws_launch_template" "catalogue" {
  name_prefix   = "${var.project}-${var.environment}-catalogue-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name
  
  vpc_security_group_ids = [local.catalogue_sg_id]
  user_data = base64encode(file("${path.module}/bootstrap.sh"))
}
```

### 2. Auto Scaling Group
```hcl
resource "aws_autoscaling_group" "catalogue" {
  name                = "${var.project}-${var.environment}-catalogue-asg"
  vpc_zone_identifier = local.private_subnet_ids
  target_group_arns   = [aws_lb_target_group.catalogue.arn]
  health_check_type   = "ELB"
  
  min_size         = var.min_capacity
  max_size         = var.max_capacity  
  desired_capacity = var.desired_capacity
}
```

### 3. Target Group
```hcl
resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  
  health_check {
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 5
    interval            = 30
  }
}
```

## Input Variables

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| project | Project name | string | "roboshop" |
| environment | Environment name | string | "dev" |
| aws_region | AWS region | string | "us-east-1" |
| instance_type | EC2 instance type | string | "t3.micro" |
| key_name | EC2 key pair name | string | "roboshop-key" |
| zone_id | Route53 hosted zone ID | string | - |
| zone_name | Route53 zone name | string | - |
| desired_capacity | Desired ASG capacity | number | 2 |
| max_capacity | Maximum ASG capacity | number | 4 |
| min_capacity | Minimum ASG capacity | number | 1 |

## Data Sources

| Data Source | Description | SSM Parameter |
|-------------|-------------|---------------|
| private_subnet_ids | Private subnet IDs | /${project}/${environment}/private_subnet_ids |
| vpc_id | VPC ID | /${project}/${environment}/vpc_id |
| catalogue_sg_id | Catalogue security group ID | /${project}/${environment}/catalogue_sg_id |
| backend_alb_sg_id | Backend ALB security group ID | /${project}/${environment}/backend_alb_sg_id |
| amazon_linux | Latest Amazon Linux 2 AMI | AWS AMI data source |

## Outputs

| Output | Description |
|--------|-------------|
| catalogue_asg_name | Auto Scaling Group name |
| catalogue_asg_arn | Auto Scaling Group ARN |
| catalogue_target_group_arn | Target Group ARN |
| catalogue_launch_template_id | Launch Template ID |
| catalogue_dns_name | DNS name for catalogue service |

## Service Bootstrap Script

The `bootstrap.sh` script handles:

### System Setup
- Sets hostname to "catalogue"
- Updates system packages
- Installs Node.js 18.x runtime

### Application Deployment
- Creates application user (roboshop)
- Downloads catalogue service code
- Installs NPM dependencies
- Configures MongoDB connection

### Service Configuration
- Creates systemd service file
- Enables automatic startup
- Configures service restart policies
- Sets environment variables

### Monitoring Setup
- Installs CloudWatch agent
- Configures metrics collection
- Sets up log aggregation
- Enables system monitoring

## Auto Scaling Configuration

### Scaling Policies
- **Scale Up**: Add 1 instance when CPU > 80%
- **Scale Down**: Remove 1 instance when CPU < 20%
- **Cooldown**: 300 seconds between scaling events

### CloudWatch Alarms
- **CPU High**: Triggers scale-up action
- **CPU Low**: Triggers scale-down action
- **Evaluation**: 2 periods of 5 minutes each

### Health Checks
- **ELB Health Check**: Primary health check method
- **Grace Period**: 300 seconds for initialization
- **Health Check Path**: `/health`
- **Success Criteria**: HTTP 200 response

## Security Configuration

### Security Groups
- Uses dedicated catalogue security group
- Allows inbound traffic from backend ALB
- Permits outbound internet access for updates

### Network Security
- Deployed in private subnets only
- No direct internet access
- Communication via internal load balancer

## Database Integration

### MongoDB Connection
- Connects to MongoDB via internal DNS
- Connection string: `mongodb://mongodb.roboshop.internal:27017/catalogue`
- Database name: `catalogue`
- Connection pooling enabled

### Data Schema
- Product information storage
- Category management
- Inventory tracking
- Search indexing

## Performance Optimization

### Instance Configuration
- **Instance Type**: t3.micro (burstable performance)
- **AMI**: Amazon Linux 2 (optimized for AWS)
- **Storage**: GP2 EBS volumes
- **Network**: Enhanced networking enabled

### Application Optimization
- **Node.js**: Version 18.x for performance
- **PM2**: Process manager for clustering
- **Caching**: In-memory caching for frequently accessed data
- **Connection Pooling**: Database connection optimization

## Monitoring and Logging

### CloudWatch Metrics
- **System Metrics**: CPU, memory, disk utilization
- **Application Metrics**: Request count, response time
- **Custom Metrics**: Business-specific metrics
- **Alarms**: Automated alerting for issues

### Log Management
- **System Logs**: `/var/log/messages`
- **Application Logs**: Service-specific logging
- **Log Groups**: Organized by service and environment
- **Retention**: 30-day log retention policy

## Deployment Instructions

### Prerequisites
1. VPC infrastructure deployed (00.vpc)
2. Security groups configured (10.security_groups)
3. Database layer deployed (40.databases)
4. Backend ALB deployed (50.backend_alb)
5. Route53 hosted zone available

### Deployment Steps
```bash
# Navigate to catalogue directory
cd 60.catalogue

# Initialize Terraform
terraform init

# Plan deployment
terraform plan

# Apply configuration
terraform apply
```

### Post-Deployment Verification
```bash
# Check Auto Scaling Group
aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names roboshop-dev-catalogue-asg

# Verify target group health
aws elbv2 describe-target-health \
  --target-group-arn $(terraform output -raw catalogue_target_group_arn)

# Test service endpoint
curl -H "Host: catalogue.yourdomain.com" \
  http://backend-alb.yourdomain.com/health
```

## Integration with Backend ALB

### Target Group Registration
- Auto Scaling Group automatically registers instances
- Health checks ensure only healthy instances receive traffic
- Automatic deregistration on instance termination

### Load Balancer Rules
- Path-based routing: `/catalogue/*`
- Host-based routing: `catalogue.yourdomain.com`
- Health check integration
- Sticky sessions if required

## Troubleshooting

### Common Issues
1. **Service Not Starting**
   - Check bootstrap script execution
   - Verify MongoDB connectivity
   - Review systemd service logs

2. **Health Check Failures**
   - Confirm `/health` endpoint response
   - Check security group rules
   - Verify target group configuration

3. **Auto Scaling Issues**
   - Review CloudWatch alarms
   - Check scaling policies
   - Verify instance limits

### Debugging Commands
```bash
# Check service status
systemctl status catalogue

# View service logs
journalctl -u catalogue -f

# Check ASG activity
aws autoscaling describe-scaling-activities \
  --auto-scaling-group-name roboshop-dev-catalogue-asg

# Monitor CloudWatch metrics
aws cloudwatch get-metric-statistics \
  --namespace AWS/EC2 \
  --metric-name CPUUtilization \
  --dimensions Name=AutoScalingGroupName,Value=roboshop-dev-catalogue-asg \
  --start-time 2023-01-01T00:00:00Z \
  --end-time 2023-01-01T23:59:59Z \
  --period 300 \
  --statistics Average
```

## Best Practices

### Performance
- Use appropriate instance types for workload
- Configure proper health check intervals
- Implement connection pooling
- Enable CloudWatch detailed monitoring

### Security
- Use IAM roles for EC2 instances
- Implement least privilege access
- Enable encryption at rest and in transit
- Regular security updates

### Cost Optimization
- Use spot instances for non-critical environments
- Configure appropriate auto-scaling thresholds
- Monitor and optimize resource utilization
- Use reserved instances for predictable workloads

## Future Enhancements

### Planned Features
1. **Container Support**: Docker containerization
2. **Service Mesh**: Istio integration
3. **Blue-Green Deployment**: Zero-downtime deployments
4. **Canary Releases**: Gradual rollout strategy
5. **API Gateway**: Centralized API management

### Monitoring Enhancements
- Application Performance Monitoring (APM)
- Distributed tracing
- Custom business metrics
- Advanced alerting rules

---

**Note**: This service is part of the RoboShop microservices architecture. Ensure all dependencies are deployed before deploying this service.
