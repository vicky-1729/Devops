provider "aws" {
  region = "us-east-1" # or your preferred region
}

resource "aws_security_group" "ec2-allow-all" {
  name        = "ec2-allow-all"
  description = "allow - inbound and outbound"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all inbound traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "allow-vs"
  }
}
