module "frontend"{
    source = "../modules/sg"
    # input variables

  # Required Variables
  vpc_id      = local.vpc_id
  project     = var.project
  environment = var.environment
  sg_name     = var.frontend_sg_name
  sg_desc     = var.frontend_sg_desc
  
  # Optional Custom Tags
  sg_tags = {
    Name = "${var.project}-${var.environment}-${var.frontend_sg_name}"
  }
}
resource "aws_security_group_rule" "frontend_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend.sg_id
}
module "bastion"{
    source = "../modules/sg"
    # input variables

  # Required Variables
  vpc_id      = local.vpc_id
  project     = var.project
  environment = var.environment
  sg_name     = var.bastion_sg_name
  sg_desc     = var.bastion_sg_desc

}
resource "aws_security_group_rule" "bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

module "backend_alb" {
  source = "../modules/sg"

  vpc_id      = local.vpc_id
  project     = var.project
  environment = var.environment
  sg_name     = var.backend_alb_sg_name
  sg_desc     = var.backend_alb_sg_desc
}

resource "aws_security_group_rule" "backend_alb_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id # Source via proxy sg_id
  security_group_id = module.backend_alb.sg_id # Destination
}



# for vpn 
module "vpn" {
  source = "../modules/sg"

  vpc_id      = local.vpc_id
  project     = var.project
  environment = var.environment
  sg_name     = var.vpn_sg_name
  sg_desc     = var.vpn_sg_desc
}

# allowing vpn ports
resource "aws_security_group_rule" "backend_alb_80_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id # Source via proxy sg_id
  security_group_id = module.backend_alb.sg_id # Destination
}
resource "aws_security_group_rule" "vpn_1194" {
  type                     = "ingress"
  from_port                = 1194
  to_port                  = 1194
  protocol                 = "udp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = module.vpn.sg_id # Destination
}
resource "aws_security_group_rule" "vpn_443" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = module.vpn.sg_id # Destination
}
resource "aws_security_group_rule" "vpn_943" {
  type                     = "ingress"
  from_port                = 943
  to_port                  = 943
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = module.vpn.sg_id # Destination
}
resource "aws_security_group_rule" "vpn_953" {
  type                     = "ingress"
  from_port                = 953
  to_port                  = 953
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = module.vpn.sg_id # Destination
}
resource "aws_security_group_rule" "vpn_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = module.vpn.sg_id # Destination
}
