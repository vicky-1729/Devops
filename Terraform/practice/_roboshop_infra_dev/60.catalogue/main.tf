# Launch Template for Catalogue Service
resource "aws_launch_template" "catalogue" {
  name_prefix   = "${var.project}-${var.environment}-catalogue-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [local.catalogue_sg_id]

  user_data = base64encode(file("${path.module}/bootstrap.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      local.common_tags,
      {
        Name = "${var.project}-${var.environment}-catalogue"
      }
    )
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group for Catalogue Service
resource "aws_autoscaling_group" "catalogue" {
  name                = "${var.project}-${var.environment}-catalogue-asg"
  vpc_zone_identifier = local.private_subnet_ids
  target_group_arns   = [aws_lb_target_group.catalogue.arn]
  health_check_type   = "ELB"
  health_check_grace_period = 300

  min_size         = var.min_capacity
  max_size         = var.max_capacity
  desired_capacity = var.desired_capacity

  launch_template {
    id      = aws_launch_template.catalogue.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project}-${var.environment}-catalogue-asg"
    propagate_at_launch = false
  }

  dynamic "tag" {
    for_each = local.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }
}

# Target Group for Catalogue Service
resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 5
    interval            = 30
    path                = "/health"
    matcher             = "200"
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue-tg"
    }
  )
}

# Auto Scaling Policies
resource "aws_autoscaling_policy" "catalogue_scale_up" {
  name                   = "${var.project}-${var.environment}-catalogue-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown              = 300
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
}

resource "aws_autoscaling_policy" "catalogue_scale_down" {
  name                   = "${var.project}-${var.environment}-catalogue-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown              = 300
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
}

# CloudWatch Alarms for Auto Scaling
resource "aws_cloudwatch_metric_alarm" "catalogue_cpu_high" {
  alarm_name          = "${var.project}-${var.environment}-catalogue-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors catalogue service cpu utilization"
  alarm_actions       = [aws_autoscaling_policy.catalogue_scale_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.catalogue.name
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "catalogue_cpu_low" {
  alarm_name          = "${var.project}-${var.environment}-catalogue-cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "20"
  alarm_description   = "This metric monitors catalogue service cpu utilization"
  alarm_actions       = [aws_autoscaling_policy.catalogue_scale_down.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.catalogue.name
  }

  tags = local.common_tags
}

# Route53 Record for Catalogue Service
resource "aws_route53_record" "catalogue" {
  zone_id = var.zone_id
  name    = "catalogue.${var.zone_name}"
  type    = "CNAME"
  ttl     = 30
  records = ["backend-alb.${var.zone_name}"]
}