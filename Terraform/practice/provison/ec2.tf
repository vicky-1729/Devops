resource "aws_instance" "roboshop_instance" {
  count = length(var.instances)
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.allow-all.id ]

  tags = {
   Name = var.instances[count.index]
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> inventory"
    on_failure = continue
  }
  provisioner "local-exec"{
    command = "echo 'instance is detsroyed' "
    when = destroy
  }
  connection {
       type        = "ssh"
       host        = self.public_ip # Or a static IP
       user        = "ec2-user"
       password    = "DevOps321"

     }

  provisioner "remote-exec" {
    inline = [
     "sudo dnf install nginx -y",
     "sudo systemctl start nginx"
    ]
  }
  provisioner "remote-exec"{
    when = destroy
    inline = [
      "sudo systemctl nginx stop",
    ]
  }
}
resource "aws_security_group" "allow-all" {
  name        = var.sg_name
  description = var.sg_description

  ingress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all inbound traffic"
  }

  egress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = var.sg_tags
  }

}
