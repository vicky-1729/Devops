resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = var.sg_des
  vpc_id      = 
  tags = merge(
    var.sg_tags,
    local.common_tags,
    {
        #roboshop-dev-sg_name
    Name = "${var.project}-${var.enviorment}-${var.sg_name}"
  })
}