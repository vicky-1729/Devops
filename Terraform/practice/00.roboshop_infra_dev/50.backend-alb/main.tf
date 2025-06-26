module "backend_alb" {
  source = "terraform-aws-modules/alb/aws"

  name               = "${var.project}-${var.environment}-backend-alb"
  load_balancer_type = "application"
  vpc_id             = local.vpc_id
  subnets            = local.private_subnet_ids
  
  # Security Group
  create_security_group = false
  security_groups       = [local.backend_alb_sg_id]

  # ALB Configuration
  internal = true  # Since it's in private subnets
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-backend-alb"
    }
  )
}