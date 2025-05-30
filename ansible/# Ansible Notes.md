# Ansible Notes

## What is Ansible?
- Ansible is an open-source automation tool for configuration management, application deployment, and orchestration.
- Uses YAML for playbooks (declarative, human-readable).

---

## Pull vs Push Based Mechanism

**Pull:**  
- Server (like a configuration management server) pushes updates to clients.
- Requires an agent running on each client node.
- Updates are applied on a schedule (e.g., every 30 minutes).

**Push:**  
- Clients get updates only when needed (on demand).
- No agent required on the client; uses SSH for communication.
- Example: Ansible pushes changes directly from the control node.

---

## XML vs JSON vs YAML

- **XML:** Verbose, uses tags, common in older systems.
- **JSON:** Lightweight, easy for machines to parse, less readable for humans.
- **YAML:** Human-friendly, easy to read/write, used by Ansible for playbooks.

---

## Ansible Installation

- **Ubuntu:**  
  `sudo apt install ansible`
- **RHEL/CentOS:**  
  `sudo dnf install ansible`

---

## Ansible Modules

- Modules are built-in tools Ansible uses to perform tasks.
- Common modules:
  - `package`: Install or remove packages.
  - `service`: Start, stop, or enable services.
  - `ping`: Test connectivity to hosts.
  - `debug`: Print debug messages.

---

## Playbooks

- Written in YAML.
- Define tasks to run on specified hosts.
- Reusable and easy to share.
- **Example:**
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

## Inventory

- A file listing the hosts to manage (in INI or YAML format).
- **Example (INI):**
  ```ini
  [vs]
  34.201.37.195 ansible_user=ec2-user ansible_password=DevOps321

  [local]
  localhost

  [local:vars]
  COURSE=variables
  TIME=1.5hrs
  DURATION_MONTH=JAN
  ```

---

## Variables in Ansible

- **Task Level:** Defined for a single task.
- **Play Level:** Defined for all tasks in a play.
- **Inventory Level:** Defined in the inventory file and accessible in playbooks.

---

## Prompting for Variables

- Use `vars_prompt` in a playbook to ask the user for input at runtime.

---

## Useful Commands

- Run a playbook:  
  `ansible-playbook <playbook>.yml`
- Ping all hosts:  
  `ansible all -m ping -i <inventory>`

---

## Q&A

**What is a playbook?**  
A YAML file that defines a set of tasks to run on remote servers.

**What are Ansible adhoc commands?**  
One-time commands run from the CLI for quick or emergency tasks, without writing a playbook.

---

## Tips

- Use `become: yes` for sudo privileges.
- YAML indentation is important—be careful!
- Use variables to make playbooks reusable and flexible.