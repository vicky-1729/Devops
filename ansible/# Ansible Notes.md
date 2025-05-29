# Ansible Notes

## What is Ansible?
- Ansible is an open-source automation tool for configuration management, application deployment, and orchestration.
- Uses YAML for playbooks (declarative, human-readable).

---

## Pull vs Push Based Mechanism

**Pull:**
- Server sends updates to clients (e.g., CM Server).
- Needs agents on each node.
- Runs on schedule (e.g., every 30 mins).

**Push:**
- Clients request updates when needed (e.g., Ansible).
- No agents required.
- Uses SSH to connect and run tasks only when triggered.

---

## XML vs JSON vs YAML
- **XML:** Verbose, tag-based, widely used in legacy systems.
- **JSON:** Lightweight, easy for machines, less readable for humans.
- **YAML:** Human-friendly, used by Ansible for playbooks.

---

## Ansible Installation
- Ubuntu: `sudo apt install ansible`
- RHEL/CentOS: `sudo dnf install ansible`

---

## Ansible Modules
- Modules are like tools Ansible uses to perform tasks.
- Common modules:
  - `ansible.builtin.package`: Install/remove packages.
  - `ansible.builtin.service`: Start/stop/enable services.
  - `ansible.builtin.ping`: Test connectivity.
  - `ansible.builtin.debug`: Print debug messages.

---

## Playbooks
- Written in YAML.
- Define what tasks to run and on which hosts.
- Easy to reuse and share automation steps.
- Structure example:
  ```yaml
  - name: Install Apache
    hosts: webservers
    become: yes
    tasks:
      - name: Install package
        apt:
          name: apache2
          state: present
  ```

---

## Example Playbook
```yaml
- name: nginx install and running
  hosts: vs
  become: yes
  tasks:
    - name: install nginx
      ansible.builtin.package:
        name: nginx
        state: present
    - name: run nginx
      ansible.builtin.service:
        name: nginx
        state: started
        enabled: yes
```

---

## Key Concepts
- **Inventory:** List of hosts to manage (INI or YAML format).
- **Playbook:** YAML file describing automation tasks.
- **Module:** Reusable unit (e.g., `package`, `service`, `ping`).
- **Task:** Single action in a playbook.
- **Role:** Collection of tasks, files, templates, variables.

---

## Useful Commands
- Run playbook:  
  `ansible-playbook <playbook>.yml`
- Check hosts:  
  `ansible all -m ping -i <inventory>`

---

## Q&A

**1. What is a playbook?**
- It is a list of plays where we can execute against group of remote servers to perform multiple tasks.

**2. What are Ansible adhoc commands?**
- It is an Ansible command line tool to perform just one-time actions or emergency actions when you don't have to create a playbook and push.

---

## Tips
- Use `become: yes` for privilege escalation (sudo).
- Indentation and YAML structure are critical.
- Use variables for reusability.