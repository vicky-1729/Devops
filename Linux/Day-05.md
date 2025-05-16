## DAY-05 – Linux Permissions, Ownership, Package & Service Management

---

### 🔐 Permissions

| Symbol | Meaning | Value |
| ------ | ------- | ----- |
| R      | Read    | 4     |
| W      | Write   | 2     |
| X      | Execute | 1     |

#### ➤ Permission Format Breakdown

```
-    rwx   r-x   r-x
|    |     |     |
|    |     |     └── Others
|    |     └──────── Group
|    └────────────── User
└── File/Directory Type
```

#### ➤ Symbolic Permission Commands

```bash
chmod ugo+w <file_name>   # Add write access to User, Group, Others
chmod ugo-w <file_name>   # Remove write access from User, Group, Others
```

#### ➤ Numeric (Octal) Permission Format

```bash
chmod 755 <file_name>
```

* **7 = 4+2+1 = rwx** → Full access for User
* **5 = 4+1   = r-x** → Read and Execute for Group
* **5 = 4+1   = r-x** → Read and Execute for Others

✅ Only the **owner** or **root** can change file permissions.

---

### 👤 Ownership

#### ➤ Changing File Ownership

```bash
chown <user> <file_name>               # Change ownership to a specific user
chown <user>:<group> <file_name>       # Change ownership to user and group
```

✅ Only **root** can modify file ownership.

**Examples:**

```bash
chown vsvicky demo.txt
chown vsvicky:vsgroup demo.txt
```

---

### 🔑 Key-Based SSH Access

#### ➤ SSH Key Setup Steps

1. Create the user account (if not already created)
2. Ask the user to send their **public SSH key**
3. On the server (as admin):

   * Create a `.ssh` directory under `/home/<user>`
   * Set permission `700` to `.ssh`
   * Create `authorized_keys` file inside `.ssh`
   * Set permission `600` to `authorized_keys`
   * Paste the public key into the `authorized_keys` file
   * Change ownership of `.ssh` and its contents to the user

#### ➤ Commands:

```bash
mkdir /home/vs/.ssh
chmod 700 /home/vs/.ssh
chown vs:vs /home/vs/.ssh

touch /home/vs/.ssh/authorized_keys
chmod 600 /home/vs/.ssh/authorized_keys
chown vs:vs /home/vs/.ssh/authorized_keys
```

#### ➤ Test SSH Login:

```bash
ssh -i <private_key_file> <ec2-user>@<IP_ADDRESS>
```

---

### 🔐 Root Access (sudo)

* Config File: `/etc/sudoers`
* Recommended: Add the user to the **wheel** group for sudo access

✅ Safer approach: Configure user with **NOPASSWD** option in `sudoers` file if needed.

---

## 📦 Package Management

* For **Ubuntu/Debian-based systems**: Use `apt-get`
* For **RHEL/CentOS/Fedora-based systems**: Use `dnf` or `yum`

### ➤ Common Commands

```bash
dnf install <package_name>             # Install package
dnf install <package_name> -y          # Install without confirmation

dnf list installed                     # List all installed packages
dnf list available                     # List all available packages
dnf list available | grep python       # Filter available packages by name

dnf remove <package_name>              # Uninstall a package
dnf remove <package_name> -y           # Uninstall without confirmation
```

---

## 🛠️ Service Management (systemd)

✅ Requires **root** or `sudo` access

### ➤ Systemctl Commands

```bash
systemctl start <service>     # Start a service
systemctl stop <service>      # Stop a service
systemctl restart <service>   # Restart a service
systemctl status <service>    # View current status
systemctl enable <service>    # Enable auto-start on boot
systemctl disable <service>   # Disable auto-start on boot
```

**Example:**

```bash
dnf install nginx
systemctl start nginx
systemctl enable nginx
```

---

## ⏱️ Fixing SSH Session Timeout

### ➤ Edit Configuration File

```bash
/etc/ssh/sshd_config
```

### ➤ Add or Update These Settings

```conf
ClientAliveInterval 2400
ClientAliveCountMax 3
```

### ➤ Apply the Changes

```bash
systemctl restart sshd
```

