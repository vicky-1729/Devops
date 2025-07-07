
resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.vpn_sg_id]
  subnet_id = local.private_subnet_id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-catalogue"
    }
  )
}
resource "aws_route53_record" "catalogue" {
    zone_id         = var.zone_id
    name            = "catalogue-${var.environment}.${var.zone_name}"
    type            = "A"
    ttl             = 1
    records         = [aws_instance.catalogue.private_ip]
    allow_overwrite = true
}

