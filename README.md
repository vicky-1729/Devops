# 🌐 Roboshop DevOps & Infrastructure Notes

---

## 🌍 DNS Flow (When You Type `google.com`)

1. **Browser Cache**
2. **OS Cache**
3. **OS Resolver**
4. **ISP DNS Resolver**
5. **Root DNS Servers**
6. **TLD Info** (e.g., `.com`)
7. **TLD Server Lookup** → `.com` TLD
8. **Name Servers** → Who manages the domain
9. **A Record** → Returns IP address

---

## 🔗 Domain & DNS

- **Name Servers**: Tell where the domain is hosted.
- **Domain Registrar**: Sells the domain (GoDaddy, Namecheap, etc.) and provides default name servers.
- **Hosted Zone (AWS)**:
  - Create a hosted zone in AWS Route 53
  - Copy the NS (Name Server) records
  - Update your domain provider with these NS records
- **TTL (Time To Live)**: Time DNS record is cached before refreshing

### 📘 DNS Record Types

| Record | Meaning               |
|--------|------------------------|
| A      | IPv4 Address           |
| AAAA   | IPv6 Address           |
| CNAME  | Alias (points to domain) |
| MX     | Mail Exchange (email)  |
| TXT    | Text (used for verification) |
| NS     | Name Servers           |

---

## ☁️ AWS Free Tier (750 Hours/month)

- 750 hrs = 1 instance running 24/7 for 31 days
- **Examples**:
  - 1 instance → 1 month
  - 2 instances → 15.5 days
  - 11 instances → ~3 days

---

## 💻 Tools

- **Mobaxterm**: SSH and terminal emulator for Windows
- **Change shell prompt**:

```bash
sudo set-prompt frontend
```

---

## 🛢️ Databases

### RDBMS (Relational):

- Examples: MySQL, Oracle, PostgreSQL, MSSQL
- Uses: Tables, Columns, Primary Keys, Foreign Keys

### NoSQL (MongoDB):

- Stores data as JSON-like documents

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

- Non-human users
- No login access
- Used to run applications

### Create system user:

```bash
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
```

- Home Directory: `/app`
- Shell: `/sbin/nologin`
- Example:

```text
nginx:x:991:990:Nginx web server:/var/lib/nginx:/sbin/nologin
```

- Encrypted password stored in: `/etc/shadow`

---

## 📁 Directory Setup

- Create one folder (e.g., `/app`)
- Download your code there (e.g., catalogue)

---

## 📦 Install Packages

```bash
dnf install nginx
dnf install mongodb-org
```

❌ Cannot do `dnf install catalogue` → Because it’s a custom microservice.

---

## 🧑‍💻 Programming Languages & Extensions

| Language | Extension |
|----------|-----------|
| JavaScript | `.js`   |
| Java       | `.java` |
| Python     | `.py`   |
| Go         | `.go`   |

---

## ⚙️ Build Tools & Dependencies

- All programming languages have **dependencies/libraries**
- Use **build tools** to:
  - Compile code
  - Download dependencies
  - Prepare app for running

### NodeJS

- Build tool: `npm` (Node Package Manager)
- Build file: `package.json`

```bash
npm install   # Installs dependencies from package.json
```

---

## ✅ Setup Steps for Any Microservice

1. Install programming language
2. Create directory `/app`
3. Create user `roboshop`
4. Download code
5. Install dependencies

---

## 🛠️ Managing Microservices with systemd

> Microservices like `catalogue` or `cart` **won’t start automatically**

### Steps:

1. Create service file in:

```bash
/etc/systemd/system/
```

2. Example: `catalogue.service`

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

3. Enable and start the service:

```bash
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
```

---

## 🔄 systemctl Commands

```bash
systemctl start <service>
systemctl stop <service>
systemctl restart <service>
systemctl enable <service>   # Start on boot
systemctl disable <service>  # Don't start on boot
```

---

🎯 You're now ready to configure, deploy, and manage Roboshop microservices like a pro!
