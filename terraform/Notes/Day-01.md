- **Provider Configuration:**  
  We are configuring the **AWS** provider in Terraform.

- **AWS Credentials:**  
  Configure your AWS credentials using the AWS CLI:  
  ```sh
  aws configure
  ```
  Or set environment variables:  
  ```sh
  export AWS_ACCESS_KEY_ID=your_access_key
  export AWS_SECRET_ACCESS_KEY=your_secret_key
  export AWS_DEFAULT_REGION=us-east-1
  ```

- **Initialize Terraform:**  
  Initialize the working directory and download provider plugins:  
  ```sh
  terraform init
  ```

- **Plan Infrastructure:**  
  See what Terraform will create or change:  
  ```sh
  terraform plan
  ```

- **Apply Configuration:**  
  Create or update resources:  
  ```sh
  terraform apply
  ```

- **Destroy Resources:**  
  Remove all managed resources:  
  ```sh
  terraform destroy --auto-approve
  ```

**Note:**  
- Everything managed by Terraform is called a "resource".  
- Make sure your provider block and credentials are correct.  
- Use `terraform fmt` to format your code.  
- The command is `terraform`, not `terrafrom`.

## Ansible Collections vs Plugins

- **Ansible Collections:**
  - Collections package and distribute Ansible content (roles, modules, plugins, playbooks, docs) together.
  - Make it easy to share and reuse automation code.
  - Install collections from Ansible Galaxy or other sources using `ansible-galaxy collection install <collection_name>`.
  - Organize content by grouping related things (e.g., all AWS modules/plugins in `amazon.aws` collection).
  - Collections can include plugins, modules, roles, and documentation.

- **Ansible Plugins:**
  - Plugins are code pieces that add features or extend Ansible’s core functionality.
  - Types include connection, lookup, filter, callback plugins, etc.
  - Customize how Ansible works (connections, data processing, output).
  - Plugins can be inside a collection or used locally in your project.

- **In short:**
  - **Collection** = bundle of Ansible content (can include plugins, modules, roles, docs, etc.)
  - **Plugin** = single piece of code that extends Ansible’s features (can be part of a collection or standalone)

---

## Ansible Limitations in State Management

- Ansible doesn't track existing infrastructure state.
- If someone changes resources directly in the cloud, Ansible can't detect or track those changes.
- Running Ansible again may create duplicate resources or errors, since it doesn't check what already exists.
- Best for configuring inside servers (software, configs, services), not for managing cloud infra (VMs, networks, storage).

---

## Problems with Doing Infra Manually

- Manual setup is time-consuming, especially for repeated tasks or multiple environments.
- Higher chance of mistakes (wrong clicks, missed steps).
- Hard to troubleshoot or audit, since there's no record of manual changes.
- Restoring infra is slow and difficult, especially in urgent situations.
- No version control—can't see changes, history, or collaborate easily.

---

## Infra as Code (IaC) - Why It's Better

- **Version Control:**  
  - Infra code is in Git, so you can track who changed what, when, and why.
  - Easy collaboration, review, rollback, and history tracking.
- **CRUD Operations:**  
  - Create, update, read, and delete infra easily and repeatably with code.
  - No need for manual console work, reducing errors and saving time.
- **Consistent Infra:**  
  - Same setup in all environments (DEV, QA, PROD).
  - Eliminates "works in DEV, fails in PROD" issues.
- **Inventory Management:**  
  - Code shows all resources/services in use—easy to audit and review.
- **Cost Management:**  
  - Automate stopping/starting infra to save money (e.g., stop servers at night).
- **Dependency Management:**  
  - IaC tools handle resource dependencies and order automatically.
- **Modules:**  
  - Reuse and extend code with modules, especially in Terraform.
  - Keeps code clean, organized, and DRY (Don't Repeat Yourself).

---

## Why We Should Use Terraform for Your Cloud Infrastructure

- Managing cloud infra manually is hard and time-consuming.
- Terraform lets you build and manage servers using code—saves time, reduces mistakes, and keeps things organized.

**Problems with Manual Setup:**
- Takes a lot of time.
- Mistakes happen easily.
- Hard to find issues.
- Difficult to rebuild.
- No tracking of changes.

**Terraform & IaC Benefits:**
- Version control for all changes.
- Easy to add, update, or delete resources.
- Same setup works in all environments.
- Clear view of all resources in code.
- Save money by automating infra schedules.
- Handles dependencies automatically.
- Use modules to avoid repeating code.

**Terraform Language (HCL) Example:**
```hcl
resource "type-of-resource" "name-you-provide" {
  ami_id        = "value"
  name          = "value"
  sg_id         = "value"
  instance_type = "value"
  subnet_id     = "value"
}
```
- Everything you create (EC2, S3, etc.) is called a resource.

**Important Terraform Commands:**
- `terraform init` — Prepares your project to use Terraform.
- `terraform plan` — Shows what changes will happen before you apply them.
- `terraform apply` — Makes the changes in your cloud.
- `terraform destroy` — Deletes the infrastructure you created.

**Final Words:**
- Using Terraform makes your cloud setup:
  - Faster
  - More reliable
  - Easier to manage
  - Easier to track