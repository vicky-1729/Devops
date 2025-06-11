locals {
    final_name = "${var.project_name}-${var.env}-${var.component}"
    ec2_tags = merge(
    var.common_tags,
    {
        environment = "dev",
        version = "1.0"
    }
  )
}

