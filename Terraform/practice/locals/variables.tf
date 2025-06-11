variable "project_name"{
    default = "roboshop"
}

variable "env"{
    default = "dev"
}

variable "component"{
    default = "cart"
}

# variable "all_names"{
#     default = "${var.project_name}-${var.env}-${var.component}"
# }
# output :Error: Variables not allowed