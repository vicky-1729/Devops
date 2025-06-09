## Ansible Collections vs Plugins

**Ansible Collections:**
- Collections are a way to package and distribute Ansible content (like roles, modules, plugins, playbooks, and docs) together.
- They make it easy to share and reuse automation code.
- You can install collections from Ansible Galaxy or other sources using `ansible-galaxy collection install <collection_name>`.

- Collections help organize content by grouping related things together (for example, all AWS modules and plugins are in the `amazon.aws` collection).
- Collections can include plugins, modules, roles, and even documentation.

**Ansible Plugins:**
- Plugins are pieces of code that add specific features or extend Ansible’s core functionality.
- There are many types of plugins: connection plugins, lookup plugins, filter plugins, callback plugins, etc.
- Plugins are usually used to customize how Ansible works (for example, how it connects to hosts, how it processes data, or how it displays output).
- Plugins can be included inside a collection, but they can also be written and used locally in your project.

**In short:**
- **Collection** = a bundle of Ansible content (can include plugins, modules, roles, docs, etc.)
- **Plugin** = a single piece of code that extends Ansible’s features (can be part of a collection or standalone)

---
## Ansible Limitations in State Management

- Ansible doesn't remember what infra is already there. If someone changes something directly in the cloud console, Ansible has no idea about those changes, so it can't track the real state of your resources.
- If you run Ansible again, it might try to create the same thing again, so you can get duplicate resources or errors. This is because Ansible just runs the tasks you give it, without checking what already exists in the cloud.
- Ansible is best for setting up stuff inside the server, like installing software, changing configs, or starting services. It's not really made for building or managing cloud infra like VMs, networks, or storage.

---

## Problems with Doing Infra Manually

- Doing everything by hand takes a lot of time, especially if you have to repeat the same steps for different environments or projects.
- More chances to make mistakes, like clicking the wrong button or missing a step, which can cause issues later.
- If something breaks, it's tough to find out what happened or who did it, because there's no record of manual changes.
- Restoring infra is slow and painful, since you have to remember all the steps and do them again, which is not fun when you're in a hurry.
- No version control, so you can't see changes, history, or work with others easily. If someone else changes something, you might not even know about it.

---

## Infra as Code (IaC) - Why It's Better

- **Version Control:**  
  - All infra code is in Git, so you can see who changed what, when, and why. You can review changes, roll back if needed, and work with your team easily. This makes collaboration and tracking super simple.
- **CRUD Operations:**  
  - Creating, updating, reading, deleting infra is easy and repeatable with code. You just write or change the code and apply it, no need to click around in the console every time. This saves time and reduces errors.
- **Consistent Infra:**  
  - Same setup in all environments (DEV, QA, PROD). You can be sure that what works in DEV will also work in PROD, because the code is the same. No more "works in DEV, fails in PROD" headaches.
- **Inventory Management:**  
  - Just look at the code to know what all services/resources you have. You get a clear picture of your infra, and it's easy to check or audit what is running and where.
- **Cost Management:**  
  - Can schedule infra to stop at night (like stop servers at 8PM, start at 8AM) to save money. You can automate these actions, so you don't have to remember to do it manually.
- **Dependency Management:**  
  - IaC tools know which resource depends on what, so they handle order and dependencies for you. You don't have to worry about creating things in the right order, the tool does it for you.
- **Modules:**  
  - Can reuse and extend code using modules, makes life easy, especially with Terraform. You can create reusable building blocks for your infra, so you don't have to write the same code again and again. This also helps keep your code clean and organized.


---

