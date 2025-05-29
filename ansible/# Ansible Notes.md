# Ansible Notes

## What is Ansible?
- **Ansible** is an open-source automation tool for configuration management, application deployment, and orchestration.
- Uses **YAML** for playbooks (declarative, human-readable).

## Key Concepts

- **Inventory:** List of hosts to manage (INI or YAML format).
- **Playbook:** YAML file describing automation tasks.
- **Module:** Reusable unit (e.g., `package`, `service`, `ping`).
- **Task:** Single action in a playbook.
- **Role:** Collection of tasks, files, templates, variables.

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

## Common Modules

- `ansible.builtin.package`: Install/remove packages.
- `ansible.builtin.service`: Start/stop/enable services.
- `ansible.builtin.ping`: Test connectivity.
- `ansible.builtin.debug`: Print debug messages.

## Useful Commands

- Run playbook:  
  `ansible-playbook <playbook>.yml`
- Check hosts:  
  `ansible all -m ping -i <inventory>`

## Tips

- Use `become: yes` for privilege escalation (sudo).
- Indentation and YAML structure are critical.
- Use variables for reusability.