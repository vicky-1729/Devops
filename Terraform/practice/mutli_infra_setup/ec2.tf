resource "aws_instance" "roboshop_instance" {
  count = length(var.instances)
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.allow-all.id ]

  tags = {
   Name = "${var.project}-${var.instances[count.index]}-${var.env}" # robshop-instance-dev or robshop-instance-prod.
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
    Name = "${var.sg_tags}-${var.env}"
  }

}




# # Resource block for AWS EC2 instance
# resource "aws_instance" "example" {
#   ami           = "ami-123456"
#   instance_type = "t2.micro"

#   # SSH connection details for remote access
#   connection {
#     type     = "ssh"
#     host     = self.public_ip
#     user     = "ec2-user"
#     password = "DevOps321"  # Note: Using passwords in code is not recommended for production
#   }

#   # Remote execution provisioner to install and start nginx
#   provisioner "remote-exec" {
#     inline = [
#       "sudo dnf install nginx -y",
#       "sudo systemctl start nginx"
#     ]
#   }

#   # Local execution when instance is created
#   provisioner "local-exec" {
#     command = "echo Instance created"
#   }

#   # Remote execution to stop nginx when instance is destroyed
#   provisioner "remote-exec" {
#     when = destroy
#     inline = [
#       "sudo systemctl stop nginx"
#     ]
#   }

#   # Local execution when instance is destroyed
#   provisioner "local-exec" {
#     when    = destroy
#     command = "echo Instance destroyed"
#   }
# }




