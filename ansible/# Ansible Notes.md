# Ansible Notes

## Index

- [What is Ansible?](#what-is-ansible)
- [Pull vs Push Based Mechanism](#pull-vs-push-based-mechanism)
- [XML vs JSON vs YAML](#xml-vs-json-vs-yaml)
- [Ansible Installation](#ansible-installation)
- [Ansible Modules](#ansible-modules)
- [Playbooks](#playbooks)
- [Inventory](#inventory)
- [Variables in Ansible](#variables-in-ansible)
  - [Ways to Define Variables](#ways-to-define-variables)
  - [Variable Precedence (Highest to Lowest)](#variable-precedence-highest-to-lowest)
- [Prompting for Variables](#prompting-for-variables)
- [Useful Commands](#useful-commands)
- [Q&A](#qa)
- [Tips](#tips)
- [What if there is no suitable Ansible module available?](#what-if-there-is-no-suitable-ansible-module-available)
- [Shell vs Command Modules in Ansible](#shell-vs-command-modules-in-ansible)
- [What are Ansible ad-hoc commands?](#what-are-ansible-ad-hoc-commands)
- [Register in Ansible](#register-in-ansible)
- [Ansible Playbook: Functions and Filters Demonstration](#ansible-playbook-functions-and-filters-demonstration)
- [Ansible Tags](#ansible-tags)
  - [Example: Deployment/Release Process](#example-deploymentrelease-process)
  - [Including Other Roles](#including-other-roles)
    - [include_role:](#include_role)
    - [import_role:](#import_role)
- [Background Commands](#background-commands)
- [Ansible Roles](#ansible-roles)
- [Ansible Templates](#ansible-templates)
- [Directory Structure in Ansible Roles](#directory-structure-in-ansible-roles)

---

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

Variables in Ansible are used to store values that can be reused throughout your playbooks, making your automation more flexible and maintainable. By defining a variable once, you can reference it in multiple places—following the DRY (Don't Repeat Yourself) principle.

**Example: Defining and Using a Variable**
```yaml
vars:
  SCHOOL: "ZPHS High School"

tasks:
  - name: Print school name from variable
    ansible.builtin.debug:
      msg: "I studied at {{ SCHOOL }}"
```

### Ways to Define Variables

Variables can be defined at different levels, each with its own scope and precedence:

- **Play level:** Defined in the `vars` section of a play.
- **Task level:** Defined for a specific task.
- **File level:** Stored in separate variable files and included as needed.
- **Prompt level:** Collected from the user at runtime using `vars_prompt`.
- **Inventory level:** Set in the inventory file for specific hosts or groups.
- **Command line:** Passed as extra variables (`--extra-vars`) when running a playbook.

### Variable Precedence (Highest to Lowest)

1. **Command line**
2. **Task level**
3. **File level**
4. **Prompt level**
5. **Play level**
6. **Inventory level**

Understanding variable precedence helps you control which value is used when the same variable is defined in multiple places.

---

## Prompting for Variables

- Use `vars_prompt` in a playbook to ask the user for input at runtime.

**Example:**
```yaml
- name: Prompt for username
  hosts: localhost
  gather_facts: false
  vars_prompt:
    - name: "username"
      prompt: "Enter your username"
      private: no
  tasks:
    - name: Show entered username
      ansible.builtin.debug:
        msg: "You entered: {{ username }}"
```

  ## Loops and Conditionals in Ansible

  Ansible allows you to perform repetitive tasks using loops and control task execution with conditionals.

  ### Loops

  Loops let you iterate over a list of items, applying the same task to each item. This is useful for installing multiple packages, creating users, or managing files.

  **Example: Installing Multiple Packages with Different States**
  ```yaml
  - name: install packages
    hosts: frontend
    become: yes
    tasks:
      - name: install packages
        ansible.builtin.package:
          name: "{{ item.name }}"
          state: "{{ item.state }}"
        loop:
          - { name: 'nginx', state: 'present' }
          - { name: 'mysql', state: 'absent' }
          - { name: 'zip', state: 'absent' }
  ```
  *This example installs `nginx`, removes `mysql` and `zip` by looping over a list of dictionaries.*

  ### Conditionals

  Conditionals (`when`) allow you to run tasks only if certain conditions are met.

  **Example:**
  ```yaml
  - name: install nginx only if on Ubuntu
    ansible.builtin.package:
      name: nginx
      state: present
    when: ansible_facts['os_family'] == 'Debian'
  ```
  *This task runs only if the target system is Debian-based.*

  **Tips:**
  - Use `loop` for iterating over lists.
  - Use `when` for conditional execution.
  - You can combine loops and conditionals for advanced automation.

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

---

## What if there is no suitable Ansible module available?

If Ansible does not provide a built-in module for your specific task, you have two main options:

1. **Develop a custom module:**  
   Write your own Ansible module in Python or another supported language to handle the required functionality.

2. **Use the `shell` or `command` module:**  
   Execute the necessary commands directly on the remote hosts using Ansible’s `shell` or `command` modules.  
   - Use `command` for simple commands without shell features.
   - Use `shell` if you need shell-specific capabilities like pipes, redirection, or environment variables.

Choose the approach that best fits your use case and security requirements.

---

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

## What are Ansible ad-hoc commands?

- Ad-hoc commands are one-off Ansible commands run directly from the command line.
- Useful for quick tasks, testing, or troubleshooting—no playbook needed.
- **Example:**  
  ```bash
  ansible all -m ping -i inventory
  ```

---

## Register in Ansible

- The `register` keyword is used to capture the output of a task.
- Stores the result in a variable for use in later tasks.
- Useful for conditional logic or debugging.
- The registered variable contains details like `stdout`, `stderr`, and `rc` (return code).

- **Example:**
  ```yaml
  - name: Check disk space
    command: df -h
    register: disk_output

  - name: Show disk output
    debug:
      var: disk_output.stdout
  ```

---

## Ansible Playbook: Functions and Filters Demonstration

This playbook demonstrates the usage of various Ansible filters and functions:

- **Default Value:** Shows how to use the `default` filter to provide a fallback value for undefined variables.
  ```yaml
  - name: check undefined variable
    ansible.builtin.debug:
      msg: "Hello, {{ person | default('Ramesh') }}"
  ```
  *Description: If the variable `person` is not defined, it will use `'Ramesh'` as the default value.*

- **String Splitting:** Uses the `split` filter to convert a comma-separated string into a list.
  ```yaml
  - name: print names
    ansible.builtin.debug:
      msg: "Hello {{ persons | split(',') }}"
  ```
  *Description: Splits the string in `persons` into a list of names using the comma as a separator.*

- **Dictionary to List Conversion:** Utilizes the `dict2items` filter to convert a dictionary (map) into a list of key-value pairs.
  ```yaml
  - name: convert map into list
    vars:
      course:
        name: ansible
        duration: 10HR
        trainer: sivakumar
    ansible.builtin.debug:
      msg: "Course Info: {{ course | dict2items  }}"
  ```
  *Description: Converts the `course` dictionary into a list of items, each with a `key` and `value`.*

- **List to Dictionary Conversion:** Uses the `items2dict` filter to convert a list of key-value pairs into a dictionary (map).
  ```yaml
  - name: convert list into map
    vars:
      course:
      - {'key': 'name', 'value': 'ansible'}
      - {'key': 'duration', 'value': '10HR'}
      - {'key': 'trainer', 'value': 'sivakumar'}
    ansible.builtin.debug:
      msg: "Course Info: {{ course | items2dict  }}"
  ```
  *Description: Converts the list of key-value pairs in `course` back into a dictionary.*

- **String Case Conversion:** Demonstrates the use of `upper` and `lower` filters to change the case of strings.
  ```yaml
  - name: convert to uppercase
    vars:
      name: "Sivakumar Reddy M"
    ansible.builtin.debug:
      msg: "Hello {{ name | upper }}"
  ```
  *Description: Converts the value of `name` to uppercase.*

  ```yaml
  - name: convert to lowercase
    vars:
      name: "Sivakumar Reddy M"
    ansible.builtin.debug:
      msg: "Hello {{ name | lower }}"
  ```
  *Description: Converts the value of `name` to lowercase.*

- **IP Address Validation:** Applies the `ansible.utils.ipaddr` filter to check if a given string is a valid IP address.
  ```yaml
  - name: check IP address is valid or not
    vars:
      ip: "192.168.1.1"
    ansible.builtin.debug:
      msg: "{{ ip | ansible.utils.ipaddr }}"
  ```
  *Description: Validates whether the value of `ip` is a valid IP address.*

---

## Ansible Tags

Tags in Ansible allow you to run specific parts of your playbook selectively. You can assign tags to plays, tasks, and roles, and then use the `--tags` or `--skip-tags` options when running `ansible-playbook` to control what gets executed.

### Example: Deployment/Release Process

1. **Announce downtime** (e.g., 6 hours)
2. **Stop the catalogue service**
3. **Remove old code**
   - Delete the `/app` directory
   - Recreate `/app`
4. **Download the new code**
5. **Restart the catalogue service**

---

## Including Other Roles

### include_role:
- Includes the role’s tasks at runtime.
- Validation happens at runtime (not before playbook execution).
- **Example:**
  ```yaml
  - name: Include the payment role at runtime
    ansible.builtin.include_role:
      name: payment
    tags: [deploy, payment]
  ```
- Tags and when conditions apply only to the include_role statement, not to the tasks inside the role.

### import_role:
- Includes and validates the role and its tasks before playbook execution (at parse time).
- **Example:**
  ```yaml
  - name: Import the user role at parse time
    ansible.builtin.import_role:
      name: user
    tags: [setup, user]
  ```
- Tags and when conditions apply to both the import_role statement and all tasks within the role.

---

Use tags to control which parts of your playbook run, and choose include_role or import_role based on when you want validation and how you want tags/conditions to apply.

---

## Background Commands
--------------------
- `&` : Runs a command in the background, but the process will stop if the terminal is closed.
- `nohup <command> &` : Runs a command in the background and keeps it running even after the terminal is closed.

**Example:**
```sh
nohup ansible-playbook -i roboshop.ini frontend.yml &>> /home/ec2-user/frontend.log &
```
- This runs the playbook in the background and logs output to `/home/ec2-user/frontend.log`.

**Check Output:**
```sh
tail -f /home/ec2-user/frontend.log
```
- Shows live updates from the log file.

---

## Ansible Roles
----------------
- **DRY (Don't Repeat Yourself):** Roles help you avoid repeating code by organizing reusable automation.
- **Roles** provide a proper directory structure for writing Ansible playbooks, making them modular and reusable.

**Syntax:**
- Use `roles:` in your playbook to include roles instead of writing all tasks directly.

---

## Ansible Templates
--------------------
- **template:**
  - Used for files with placeholders (variables) using Jinja2 formatting.
  - Placeholders are replaced with actual values at runtime, supplied through variables.
- **file:**
  - Used for static files. The content is copied as-is, without any variable changes or processing.

---

## Directory Structure in Ansible Roles
--------------------------------------
- **tasks/** : Contains the main tasks for the role (the steps to be executed).
- **files/** : Store all static files required by the role here.
- **templates/** : Store all template files (with Jinja2 placeholders) here. These files can use variables that are replaced at runtime.
- **vars/** : Contains all variables required for the role.
- **handlers/** : Handlers are notifiers in Ansible. When there is a change in something, if you want to notify another task, you can use handlers. For example, a change in the Nginx config can notify a restart Nginx task in handlers (`main.yml`).

---

## Ansible Error Handling
======================
Error handling in Ansible means deciding what to do if a task fails or succeeds.

- Use `ignore_errors: true` if you want to skip errors and continue with the next tasks.
- You can use `block`, `rescue`, and `always` to handle errors and run recovery or cleanup steps.

**Simple Example:**
```yaml
- name: Try to restart nginx
  ansible.builtin.service:
    name: nginx
    state: restarted
  ignore_errors: true

- name: Print a message if nginx restart failed
  ansible.builtin.debug:
    msg: "Nginx restart failed, but moving on."
  when: nginx_restart is failed
```

**Block/Rescue Example:**
```yaml
- name: Error handling example
  block:
    - name: Do something risky
      ansible.builtin.command: /bin/false
  rescue:
    - name: Handle the error
      ansible.builtin.debug:
        msg: "Something went wrong, but we handled it."
  always:
    - name: Always runs
      ansible.builtin.debug:
        msg: "This runs no matter what."
```

- Use `ignore_errors` for simple skipping.
- Use `block`/`rescue`/`always` for more control.

