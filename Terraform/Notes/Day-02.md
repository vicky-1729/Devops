# Terraform - Environment Setup and Concepts

---

## Softwares Required

- VS Code
- Terraform
- AWS CLI V2

## Steps

1. Create an IAM administrator user. Copy the access key and secret key. Do not push these to GitHub or the internet.
2. Configure the user on your laptop using:

   ```sh
   aws configure
   ```

3. Add the Terraform path to your system variables.

   ![alt text](terraform.svg)

---

Terraform is a popular IaC (Infrastructure as Code) tool. It is one of the best in the market now.

## **Key Benefits of Terraform**

- **Version Control:**

  Since it is code, you can maintain it in Git for version control. You can keep a complete history of your infrastructure, and collaboration is easy.

- **Consistent Infra:**

  Different environments like DEV, QA, and PROD often have different configurations. With Terraform, you can create similar infrastructure in multiple environments reliably.

- **Automated Infra CRUD:**

  Using Terraform, you can create entire infrastructure in minutes, reducing human errors. Updating and deleting infrastructure is also easy.

- **Inventory Management:**

  If you create infrastructure manually, it is tough to maintain an inventory of resources in different regions. With Terraform, you can easily see the resources you are using in different regions.

- **Cost Optimisation:**

  You can create infrastructure when you need it and delete it when you don't, saving costs.

- **Automatic Dependency Management:**

  Terraform understands the dependencies between resources and manages them for you.

- **Modular Infra:**

  Code reuse is easy. You can develop your own modules or use open-source modules to reuse infrastructure code, saving time and effort.

---

## Terraform Commands

- The first command is to initialize Terraform. This downloads the provider into the .terraform folder.

  ```sh
  terraform init
  ```

- Next, run the plan command. This compares the declared infrastructure with the existing one. This is only a plan; Terraform will not create anything yet.

  ```sh
  terraform plan
  ```

- Next, apply the infrastructure. This creates the infrastructure with your approval.

  ```sh
  terraform apply
  ```

---

## Clarification

When creating a Terraform resource, the left side of the assignment is called an argument. You must use the same name as in the Terraform AWS documentation. For example:

```hcl
resource "aws_instance" "terraform" {
    ami = "ami-09c813fb71547fc4f"
}
```

Here, the argument `ami` is from the documentation, and the right side is the value. You can provide the value directly.

You may also keep the value in a variable. The variable name is your choice:

1. It can be the same name, like `ami`
2. It can be a different name, like `ami_id`

```hcl
resource "aws_instance" "terraform" {
    ami = var.ami_id
}

variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
}
```

or

```hcl
resource "aws_instance" "terraform" {
    ami = var.ami
}

variable "ami" {
    default = "ami-09c813fb71547fc4f"
}
```