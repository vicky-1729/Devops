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

