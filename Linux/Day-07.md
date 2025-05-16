# DAY-07  
## Project - 🤖 Roboshop Project

---

A project setup made with the following:

- **AMI:** devops-practice  
- **User Name:** ec2-user  
- **Password:** DevOps321 *(use this user and password)*

---

### 🖥️ What is AMI?

**AMI (Amazon Machine Image)** is like a pre-configured OS with some packages.  
You can use it to create the exact same setup quickly.

#### ✅ Benefits of AMI:

- Quick Launch  
- Consistency  
- Customization  
- Scalability  
- Recovery and Backup  

---

### 🌐 IP Address Types

There are two types of IPs:

1. **Private IP** – Used for internal communication (within a network)  
2. **Public IP** – Used for external communication (Internet access)

- **Private IP** → Intranet  
- **Public IP** → Internet

---

### 🆚 Linux Server vs Nginx Server

| Linux Server              | Nginx Server                             |
|---------------------------|------------------------------------------|
| Like a physical machine   | A virtual web server running on Linux    |
| Handles OS-level tasks    | Serves web content over HTTP/HTTPS       |

---

### 📂 Important Nginx Directories

- `/etc/nginx/nginx.conf`  
  → This is the main configuration file.  
  → Any changes in config should be done here.  
  → After changes, **restart nginx** to apply them.

- `/usr/share/nginx/html`  
  → Default location for Nginx web files (e.g., index.html)  
  → HTML content is served from this directory.

---

## 🌍 DNS – Domain Name System

When you type `facebook.com`, your browser doesn’t understand names. It needs an IP address like `143.234.53.98`.

That’s where **DNS (Domain Name System)** helps.

Without DNS, you'd need to remember IP addresses for every website!

---

### 🧭 DNS Resolution Flow

```
+--------------------+
|   User's Browser   |
| (e.g., Chrome, FF) |
+--------------------+
         |
         v
+--------------------------+
| Local DNS Cache Check    |
| (Browser / OS / Router)  |
+--------------------------+
         |
         v
+--------------------------+
|    DNS Resolver          |
| (e.g., ISP or Public DNS)|
+--------------------------+
         |
         v
+--------------------------+
| Root DNS Server          |
| (e.g., .com, .org)       |
+--------------------------+
         |
         v
+--------------------------+
| TLD DNS Server           |
| (e.g., .com TLD)         |
+--------------------------+
         |
         v
+--------------------------+
| Authoritative DNS Server |
| (e.g., example.com)      |
+--------------------------+
         |
         v
+--------------------------+
| DNS Record (A, AAAA, MX) |
| (e.g., 192.0.2.1)        |
+--------------------------+
         |
         v
+--------------------------+
| Return IP to Resolver    |
+--------------------------+
         |
         v
+--------------------------+
| Cache IP Locally         |
| (Browser / OS / Router)  |
+--------------------------+
         |
         v
+--------------------------+
| Browser Connects to IP   |
| and Loads Website        |
+--------------------------+
```

---

### 🧠 DNS Components (Explained Simply)

- **DNS Resolver**  
  → Converts domain names into IP addresses  
  → Usually provided by your ISP or public DNS like Google (8.8.8.8)

- **Root Server**  
  → Knows where TLD servers (.com, .org, etc.) are located  
  → First step in the DNS journey

- **TLD Server**  
  → Manages domain endings like `.com`, `.net`, `.in`, etc.  
  → Points to the correct authoritative server

- **Authoritative Server**  
  → Has the actual DNS records for a domain (like A, CNAME, MX)  
  → Gives the final IP to your browser

- **TTL (Time To Live)**  
  → Temporary storage of DNS info to reduce lookups  
  → Cached until TTL expires, then fresh lookup happens

- **Name Server**  
  → Says who is managing the DNS for a domain (e.g., AWS, GoDaddy)

---

