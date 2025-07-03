resource "aws_instance" "mongodb" {
    ami                    = local.ami_id
    instance_type          = "t3.micro"
    vpc_security_group_ids = [local.vpc_sg_id]
    subnet_id              = local.database_subnet_id
    tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-mongodb"
        }
    )
}

resource "aws_instance" "redis" {
    ami                    = local.ami_id
    instance_type          = "t3.micro"
    vpc_security_group_ids = [local.vpc_sg_id]
    subnet_id              = local.database_subnet_id
    tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-redis"
        }
    )
}

resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]
  
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb"
    ]
  }
}

resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis"
    ]
  }
}