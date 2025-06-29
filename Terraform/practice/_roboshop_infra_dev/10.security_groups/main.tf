module "frontend"{
    source = "../modules/sg"
    # input variables

  # Required Variables
  project     = var.project
  environment = var.environment
  sg_name     = var.sg_name
  sg_desc     = var.sg_desc
  
  # Optional Custom Tags
  sg_tags = {
    Name = "${var.project}-${var.environment}-${var.sg_name}"
  }
}
resource "aws_security_group_rule" "frontend_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.frontend.sg_id
}