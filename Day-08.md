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




# DAY-08  
## Project # 🤖 Roboshop Project

---

We will build this project with the following details every time:

- **AMI:** devops-practice  
- **User Name:** ec2-user  
- **Password:** DevOps321  *(use this user and password)*

---

### 👤 System/Service User

System or service users are non-human users used to run applications.

- These users **do not** have login access.  
- We will create a system user for all microservices using:

```bash
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
````

This command creates:

* User: `roboshop`
* Home Directory: `/app`
* Shell: `nologin` (no login access)

---

### 🔐 Password Storage

* Passwords are stored encrypted in `/etc/shadow`.

---

### 📂 Application Directory

* All application code (e.g., `catalogue`) will be placed in: `/app`

---

### 📦 Software Installation

You can install some packages directly:

```bash
dnf install nginx
dnf install mongodb-org
```

But microservices like `catalogue` or `user` **cannot** be installed directly, since we build them from scratch.

---

### 🧑‍💻 Programming Languages & File Types

| Language | File Extension |
| -------- | -------------- |
| NodeJS   | `.js`          |
| Java     | `.java`        |
| Python   | `.py`          |
| Go       | `.go`          |

---

#### ⚙️ Build Tools

Build tools help to:

* Compile code
* Download dependencies
* Prepare the app to run

| Language | Build Tool | Build File           |
| -------- | ---------- | -------------------- |
| NodeJS   | `npm`      | `package.json`       |
| Java     | `maven`    | `pom.xml`            |
| Python   | `pip`      | `requriements.txt`   |
| go lang  | `go`       | `.go`

*Every programming language has dependencies or libraries.*

For example, to install dependencies in NodeJS:

```bash
npm install
```

This command reads the `package.json` file and installs all dependencies.

---

#### 🔄 Common Steps for All Microservices

1. Install the programming language runtime
2. Create the application directory
3. Create the system user
4. Download the code
5. Install dependencies

---

Let me know if you want me to help with systemd service files or anything else!

```

If you want, I can also prepare a sample `catalogue.service` systemd file example to go with this. Just say the word!
```
