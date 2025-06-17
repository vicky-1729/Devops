resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = merge(
    local.common_tags,{
        Name = "${var.Project}-${var.Enviorment}"
    }
  )
}