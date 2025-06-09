# Infra as Code (IaC) - Why It's Better

- **Version Control:**  
  - All infra code is in Git, so you can track who changed what, when, and why.
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

🌍 **Why We Should Use Terraform for Your Cloud Infrastructure** 🚀

- Managing cloud infrastructure by hand is hard and time-consuming.
- Terraform lets you build and manage servers using code—saving time, reducing mistakes, and making your work more organized!


**Problems with Manual Infrastructure Setup:**
- 🕒 Takes a lot of time — Setting everything up manually is slow.
- 🧯 Mistakes happen easily — One small error can break everything.
- 🕵️ Hard to find issues — If something goes wrong, it's tough to figure out why.
- 🔁 Difficult to rebuild — Re-creating the same setup again is not easy.
- 📉 No tracking — You can’t see what changed or who changed it.

✅ **Terraform & Infrastructure as Code (IaC) — A Better Way!**
- 📂 Version control — Track every change, go back in time, and work with your team.
- 🧱 Easy changes — Easily add, update, or delete resources using code.
- 🧪 Same setup everywhere — What works in DEV will work in PROD too!
- 📋 Know what you have — Just look at the code to see what services you're using.
- 💸 Save money — Automatically stop servers at night and start them again in the morning.
- 🔗 Handles dependencies — Terraform understands which resource depends on which.
- 📦 Use modules — Reuse code to avoid repeating the same setup again and again.

🔤 **Terraform Language — HCL (HashiCorp Configuration Language)**
- Terraform uses a simple language called HCL.
- Example:
  ```hcl
  resource "type-of-resource" "name-you-provide" {
    ami_id        = "value"
    name          = "value"
    sg_id         = "value"
    instance_type = "value"
    subnet_id     = "value"
  }
  ```
- 🧠 In Terraform, everything you create (like EC2, S3, etc.) is called a resource.

🛠️ **Important Terraform Commands**
- 🔧 `terraform init` — Prepares your project to use Terraform.
- 🧠 `terraform plan` — Shows what changes will happen before you apply them.
- 🚀 `terraform apply` — Actually makes the changes in your cloud.
- ❌ `terraform destroy` — Deletes the infrastructure you created.

🔚 **Final Words**
- Using Terraform makes your cloud setup:
  - ✅ Faster
  - ✅ More reliable
  - ✅ Easier to manage
  - ✅ Easier to track

---

## Ansible Collections vs Plugins

- **Ansible Collections:**
  - Package and distribute Ansible content (roles, modules, plugins, playbooks, docs) together.
  - Make it easy to share and reuse automation code.
  - Install with `ansible-galaxy collection install <collection_name>`.
  - Organize related content (e.g., all AWS modules/plugins in `amazon.aws`).
  - Can include plugins, modules, roles, and documentation.

- **Ansible Plugins:**
  - Code pieces that add or extend Ansible’s features.
  - Types: connection, lookup, filter, callback, etc.
  - Customize how Ansible works (connections, data processing, output).
  - Can be inside a collection or used locally.

- **In short:**
  - **Collection:** Bundle of Ansible content (plugins, modules, roles, docs, etc.).
  - **Plugin:** Single piece of code that extends Ansible (can be part of a collection or standalone).

---

## Ansible Limitations in State Management

- Ansible doesn't track the real state of your infrastructure.
- If resources are changed outside Ansible, it can't detect or track those changes.
- Running Ansible again may create duplicates or errors, since it doesn't check what already exists.
- Best for configuring inside servers (software, configs, services), not for managing cloud infra (VMs, networks, storage).

---

## Problems with Doing Infra Manually

- Manual setup is time-consuming, especially for repeated tasks or multiple environments.
- Higher chance of mistakes (wrong clicks, missed steps).
- Hard to troubleshoot or audit, since there's no record of manual changes.
- Restoring infra is slow and difficult, especially in urgent situations.
- No version control—can't see changes, history, or collaborate easily.



