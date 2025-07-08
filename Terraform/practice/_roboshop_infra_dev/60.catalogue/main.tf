    resource "aws_lb_target_group" "catalogue" {
      name     = "${var.project}-{var.environment}-catalogue"
      port     = 80
      protocol = "HTTP"
      vpc_id   = local.vpc_id
      health_check {
        path                = "/health"
        protocol            = "HTTP"
        matcher             = "200-299"
        interval            = 15
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 3
      }
    }
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

resource "terraform_data" "catalogue" {
    triggers_replace = [
        aws_instance.catalogue.id
    ]
    
    # Upload bootstrap script to the instance
    provisioner "file" {
        source      = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh "
    }

    # SSH connection configuration
    connection {
        type     = "ssh"
        user     = "ec2-user"
        password = "DevOps321"
        host     = aws_instance.catalogue.private_ip
    }

    # Execute catalogue configuration
    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh catalogue ${var.environment}"
        ]
    }
}
#stoping instance
resource "aws_instance_state" "catalogue_stop" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [aws_instance.catalogue]
}

#ami taking from stoped instance
resource "aws_ami_from_instance" "catalogue" {
  name               = "${var.environment}.${var.zone_name}-catalogue"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [aws_instance_state.catalogue_stop]
}

# delete the catalogue instance
resource "terraform_data" "catalogue_delete" {
    triggers_replace = [
       aws_ami_from_instance.catalogue.id
    ]

    # Execute catalogue configuration
    provisioner "local-exec" {
        inline = [
            "terraform destroy -target aws_instance.catalogue",
        ]
    }
}