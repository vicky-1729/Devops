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

### What if there is no suitable Ansible module available?

If Ansible does not provide a built-in module for your specific task, you have two main options:

1. **Develop a custom module:**  
  Write your own Ansible module in Python or another supported language to handle the required functionality.

2. **Use the `shell` or `command` module:**  
  Execute the necessary commands directly on the remote hosts using Ansible’s `shell` or `command` modules.  
  - Use `command` for simple commands without shell features.
  - Use `shell` if you need shell-specific capabilities like pipes, redirection, or environment variables.

Choose the approach that best fits your use case and security requirements.


## Shell vs Command Modules in Ansible

Ansible provides two modules for running commands on remote hosts: `shell` and `command`. Understanding their differences helps you choose the right one for your tasks.

- **`shell` module:**  
  - Runs commands through the shell on the remote host.
  - Supports shell features like pipes (`|`), redirection (`>`, `<`), and environment variables.
  - Use when you need shell-specific features or complex commands.
  - **Example:**  
    ```yaml
    - name: List files and save output to a file
      ansible.builtin.shell: ls -ltr > /tmp/output.txt
    ```

- **`command` module:**  
  - Runs commands directly, without a shell.
  - Does **not** support pipes, redirection, or variable expansion.
  - Safer and more secure—avoids shell injection risks.
  - **Example:**  
    ```yaml
    - name: List files
      ansible.builtin.command: ls -l
    ```

**Tip:**  
Use `command` whenever possible for security and reliability. Use `shell` only when shell features are required.

---

### What are Ansible ad-hoc commands?

- Ad-hoc commands are one-off Ansible commands run directly from the command line.
- Useful for quick tasks, testing, or troubleshooting—no playbook needed.
- **Example:**  
  ```bash
  ansible all -m ping -i inventory
  ```