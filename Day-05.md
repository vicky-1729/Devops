## DAY-05 - 
 ` Linux Permissions, Ownership, Package & Service Management `

---

### 🔐 Permissions

| Symbol | Meaning  | Value |
|--------|----------|-------|
| R      | Read     | 4     |
| W      | Write    | 2     |
| X      | Execute  | 1     |

#### Format:

```
-    rwx   r-x   r-x
|    |     |     |
|    |     |     └── Others
|    |     └──────── Group
|    └────────────── User
└── File/Directory Type
```

#### Symbolic Permission Commands:

```bash
chmod ugo+w <file_name>   # Add write access to User, Group, Others
chmod ugo-w <file_name>   # Remove write access from User, Group, Others
```

#### Numeric (Octal) Permission Format:

```bash
chmod 755 <file_name>
```

- **7 = 4+2+1 = rwx** (User)
- **5 = 4+1   = r-x** (Group)
- **5 = 4+1   = r-x** (Other)

> ✅ Only the **owner** or **root** can change permissions.

---

### 👤 Ownership

```bash
chown <user> <file_name>               # Change ownership to user
chown <user>:<group> <file_name>       # Change ownership to user and group
```

> ✅ Only **root** can modify file ownership.

**Examples:**

```bash
chown vsvicky demo.txt
chown vsvicky:vsgroup demo.txt
```

---

### 🔑 Key-Based SSH Access

#### Steps:

1. Create the user
2. User sends their public key to admin
3. Admin:
   - Create `.ssh` directory under `/home/<user>`
   - Set permission `700` to `.ssh`
   - Create `authorized_keys` inside `.ssh`
   - Set permission `600` to `authorized_keys`
   - Add the public key to this file
   - Change ownership of files to user

#### Commands:

```bash
mkdir /home/vs/.ssh
chmod 700 /home/vs/.ssh
chown vs:vs /home/vs/.ssh

touch /home/vs/.ssh/authorized_keys
chmod 600 /home/vs/.ssh/authorized_keys
chown vs:vs /home/vs/.ssh/authorized_keys
```

#### Test Login:

```bash
ssh -i <private_key_file> <ec2-user>@<IP_ADDRESS>
```

---

### 🔐 Root Access (sudo)

- **File to update**: `/etc/sudoers`
- Recommended: Add user to **wheel** group

> ✅ Safest method: Add user to wheel group with `NOPASSWD` option

---

## 📦 Package Management

- Ubuntu-based → `apt-get`
- RHEL-based → `yum` or `dnf`

### Commands:

```bash
dnf install <package_name>             # Install package
dnf install <package_name> -y          # Install without confirmation

dnf list installed                     # List installed packages
dnf list available                     # List available packages
dnf list available | grep python       # Filter by name

dnf remove <package_name>              # Remove package
dnf remove <package_name> -y           # Remove without confirmation
```

---

## 🛠️ Service Management (systemd)

> ✅ Requires `sudo` or `root` access

### Commands:

```bash
systemctl start <service>     # Start service
systemctl stop <service>      # Stop service
systemctl restart <service>   # Restart service
systemctl status <service>    # Check status
systemctl enable <service>    # Start on boot
systemctl disable <service>   # Do not start on boot
```

**Example:**

```bash
dnf install nginx
systemctl start nginx
systemctl enable nginx
```

---

## ⏱️ SSH Session Timeout Fix

### File to Edit:

```bash
/etc/ssh/sshd_config
```

### Add or Update:

```conf
ClientAliveInterval 2400
ClientAliveCountMax 3
```

### Apply Changes:

```bash
systemctl restart sshd
```

---

✅ With this, you have a clear understanding of Linux permissions, users, package management, and system services!
