# Ansible Notes

## What is Ansible?
Ansible is a simple tool to automate tasks like installing software, configuring servers, and deploying apps. It uses YAML files called playbooks. You don’t need to install any agent on your servers—Ansible connects over SSH and works agentless.

## Pull vs Push Based Mechanism
- **Pull:** Each server pulls updates from a central place (needs an agent on every server, like Puppet or Chef).
- **Push:** You push updates from your laptop or control node to servers. Ansible works this way—no agent needed, just SSH.

## XML vs JSON vs YAML
- **XML:** Old, hard to read, lots of tags.
- **JSON:** Better, used by many tools, but still not very human-friendly.
- **YAML:** Super easy to read and write. Ansible uses YAML for all playbooks and config files.

## Ansible Installation
- On Ubuntu:
  ```sh
  sudo apt install ansible
  ```
- On RHEL/CentOS:
  ```sh
  sudo dnf install ansible
  ```
- You can also install with pip: `pip install ansible` (works on any OS with Python)

## Ansible Modules
Modules are like small programs Ansible uses to do activities (install, copy, start service, etc).
- `package`: Install/remove packages (works for yum, apt, dnf, etc)
- `service`: Start/stop/restart services
- `ping`: Test connection to hosts
- `copy`: Copy files to remote servers
- `template`: Copy files with variables (Jinja2)
- `debug`: Print messages for troubleshooting

## Playbooks
Playbooks are YAML files with steps (tasks) to run on your servers. You can group tasks, use variables, loops, and conditions.
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
- `hosts:` tells Ansible which servers to run on.
- `become: yes` means use sudo.
- `tasks:` is a list of steps to run.

## Inventory
A file with the list of servers you want to manage. You can use INI or YAML format.
```ini
[web]
1.2.3.4 ansible_user=ec2-user
```
- You can group servers and set variables per group or host.

## Variables in Ansible
Variables let you reuse values. Define once, use everywhere. Makes playbooks flexible and DRY (Don’t Repeat Yourself).
```yaml
vars:
  SCHOOL: "ZPHS High School"
tasks:
  - name: Print school name
    ansible.builtin.debug:
      msg: "I studied at {{ SCHOOL }}"
```

## Ways to Define Variables
- In playbooks (vars)
- In tasks
- In separate files (vars_files)
- In inventory
- On the command line (`--extra-vars`)

## Variable Precedence (Highest to Lowest)
1. Command line
2. Task
3. File
4. Prompt
5. Play
6. Inventory

## Prompting for Variables
Ask user for input when running playbook.
```yaml
vars_prompt:
  - name: "username"
    prompt: "Enter your username"
    private: no
```

## Loops and Conditionals
- **Loop:** Run a task for each item in a list (install many packages, create users, etc).
- **When:** Run a task only if a condition is true (like if OS is Ubuntu).

## Useful Commands
- Run playbook:
  ```sh
  ansible-playbook playbook.yml
  ```
- Ping all hosts:
  ```sh
  ansible all -m ping -i inventory
  ```
- Check syntax:
  ```sh
  ansible-playbook playbook.yml --syntax-check
  ```

## Tips
- Use `become: yes` for sudo.
- Indentation matters in YAML! (Always use spaces, not tabs)
- Use variables to avoid repeating values.
- Use handlers to restart services only when needed.

## Shell vs Command Modules
- **shell:** Use for commands with pipes, redirection, or shell features.
- **command:** Use for simple commands (safer, no shell features).

## Register in Ansible
Capture output of a task to use later.
```yaml
- name: Check disk space
  command: df -h
  register: disk_output
- name: Show disk output
  debug:
    var: disk_output.stdout
```

## Ansible Playbook: Functions and Filters
- Use filters like `default`, `split`, `dict2items`, `items2dict`, `upper`, `lower` to work with variables and data.

## Ansible Tags
Tags let you run only certain parts of your playbook. Good for big playbooks or when you want to run only setup or deploy steps.
```sh
ansible-playbook playbook.yml --tags "setup"
```

## Including Other Roles
- **include_role:** Adds a role at runtime. Tags/when apply only to the include statement.
- **import_role:** Adds a role before running. Tags/when apply to all tasks in the role.
- Roles help you organize code and reuse logic for different servers or projects.

## Background Commands
- `&` : Run in background, stops if terminal closes.
- `nohup <command> &` : Run in background, keeps running after terminal closes.
- Use `tail -f <logfile>` to watch logs live.

## Ansible Roles
Roles are folders with a standard structure to organize your playbooks and make them reusable.
- `tasks/` : Main steps
- `files/` : Static files
- `templates/` : Jinja2 templates (with variables)
- `vars/` : Variables
- `handlers/` : Notifiers (e.g., restart service)
- `defaults/` : Default variables
- `meta/` : Role dependencies

## Ansible Templates
- **template:** For files with variables (Jinja2). Values are filled in at runtime.
- **file:** For static files. Copied as-is.
- Templates are great for config files that change per environment.

## Ansible Error Handling
- Use `ignore_errors: true` to skip errors and keep going.
- Use `block`, `rescue`, `always` for more control and to handle errors cleanly.
```yaml
- name: Try to restart nginx
  ansible.builtin.service:
    name: nginx
    state: restarted
  ignore_errors: true
- name: Print if failed
  ansible.builtin.debug:
    msg: "Nginx restart failed, but moving on."
  when: nginx_restart is failed
```

## Vault and Secrets Management
Vault means: Keep your secrets (like passwords) in a file and encrypt it.

### Ansible Vault
- Ansible Vault lets you encrypt files or variables in Ansible.
- You can use it to keep your secrets safe in your playbooks.

#### Ansible Vault Commands (Syntax & Examples)
- Create encrypted file:
  ```sh
  ansible-vault create secrets.yml
  ```
- View encrypted file:
  ```sh
  ansible-vault view secrets.yml
  ```
- Edit encrypted file:
  ```sh
  ansible-vault edit secrets.yml
  ```
- Encrypt existing file:
  ```sh
  ansible-vault encrypt vars.yml
  ```
- Decrypt file:
  ```sh
  ansible-vault decrypt secrets.yml
  ```
- Use vault in playbook:
  ```sh
  ansible-playbook site.yml --ask-vault-pass
  # or
  ansible-playbook site.yml --vault-password-file ~/.vault_pass.txt
  ```

### AWS SSM Parameter Store
- Cloud service to keep secrets safe. No need to manage files or keys. AWS takes care of it.
- You can get secrets from SSM Parameter Store using the `aws_ssm` lookup in your playbook.
- Example:
  ```yaml
  vars:
    db_password: "{{ lookup('aws_ssm', '/prod/db/password', region='us-east-1') }}"
  ```
- SSM is better for big teams or cloud setups—no need to share vault passwords.

**Summary:**
- Use Ansible Vault for simple/small setups.
- Use AWS SSM Parameter Store for cloud, big teams, or easy/secure secret management.

