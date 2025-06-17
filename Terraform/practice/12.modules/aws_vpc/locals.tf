locals {
    common_tags={
        Project = var.project
        Enviorment = var.env
        Terraform = "true"
    }
}