module "frontend"{
    source = "../modules/sg"
    # input variables

  # Required Variables
  project     = var.project
  environment = var.environment
  sg_name     = var.sg_name
  sg_desc     = var.sg_desc
  
  # Optional Custom Tags
  sg_tags = {
    Name = "${var.project}-${var.environment}-${var.sg_name}"
  }
}