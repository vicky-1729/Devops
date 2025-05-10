## 💻 Tools

- **Mobaxterm**: SSH and terminal emulator for Windows
- **Iterm**: SSH and terminal for Mac
- **Change shell prompt**:

```bash
sudo set-prompt frontend
```

---

## 🛢️ Databases

### RDBMS (Relational Databases):

- Examples: MySQL, Oracle, PostgreSQL, MSSQL
- Uses: Tables, Columns, Primary Keys, Foreign Keys

### NoSQL (MongoDB):

- Stores data as **JSON-like documents**

```json
{
  "name": "sivakumar",
  "email": "info@joindevops.com"
}
```

---

## 🔁 Loopback

- `127.0.0.1` = `localhost`

---

## 👤 System/Service User

- **Non-human users** created to run applications
- **No login access** for security
- Example: `nginx` user for running the Nginx web server

### Create a system user:

```bash
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
```

- Home Directory: `/app`
- Shell: `/sbin/nologin`
- Example from `/etc/passwd`:

```text
nginx:x:991:990:Nginx web server:/var/lib/nginx:/sbin/nologin
```

- **Encrypted password** stored in: `/etc/shadow`

---

## 📁 Directory Setup

- Create a folder (e.g., `/app`)
- Download your code there (e.g., `catalogue`)

---

## 📦 Install Packages

```bash
dnf install nginx
dnf install mongodb-org
```

❌ **Cannot install `catalogue` directly** via `dnf`, as it's a custom microservice.

---

## 🧑‍💻 Programming Languages & Extensions

| Language     | Extension |
|--------------|-----------|
| JavaScript   | `.js`     |
| Java         | `.java`   |
| Python       | `.py`     |
| Go           | `.go`     |

---

## ⚙️ Build Tools & Dependencies

- **All programming languages** require dependencies or libraries.
- **Build tools** help to:
  - Compile code
  - Download dependencies
  - Prepare applications for running

### NodeJS:

- **Build tool**: `npm` (Node Package Manager)
- **Build file**: `package.json`

```bash
npm install   # Installs dependencies listed in package.json
```

---

## ✅ Setup Steps for Any Microservice

1. Install the programming language (e.g., NodeJS)
2. Create directory `/app`
3. Create user `roboshop`
4. Download the code for your microservice (e.g., `catalogue`)
5. Install necessary dependencies

---

## 🛠️ Managing Microservices with systemd

> Microservices like `catalogue` or `cart` **won’t start automatically**.

### Steps to create and manage systemd services:

1. **Create service file** in `/etc/systemd/system/`

Example: `catalogue.service`

```ini
[Unit]
Description=Catalogue Service
After=network.target

[Service]
User=roboshop
WorkingDirectory=/app
ExecStart=/bin/node catalogue.js
Restart=always

[Install]
WantedBy=multi-user.target
```

2. Enable and start the service:

```bash
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
```

---

## 🔄 systemctl Commands

```bash
systemctl start <service>     # Start service
systemctl stop <service>      # Stop service
systemctl restart <service>   # Restart service
systemctl enable <service>    # Enable service to start on boot
systemctl disable <service>   # Disable service from starting on boot
```

---

🎯 You’re now ready to configure, deploy, and manage **Roboshop microservices** like a pro!
