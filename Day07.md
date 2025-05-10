## 🖥️ Project - Roboshop Project

### Project Setup
- **AMI**: `devops-practice`
- **Username**: `ec2-user`
- **Password**: `DevOps321`

---

### What is an AMI (Amazon Machine Image)?

An **AMI** is a pre-configured OS with specific packages that you can use to launch identical setups quickly.

#### Benefits of AMI:
- **Quick Launch**: Deploy instances rapidly.
- **Consistency**: Ensures all instances are identical.
- **Customization**: You can customize AMI with additional packages.
- **Scalability**: Scale your infrastructure by launching multiple instances.
- **Recovery and Backup**: Easy to create backups of your setup.

---

## 🌐 IP Addresses

### Types of IPs:
1. **Private IP**: Used for internal communication within a network (Intranet).
2. **Public IP**: Used for external communication (Internet).

---

## 🖧 Linux Server vs Nginx Server

- **Linux Server**: Refers to the physical or virtual server running Linux OS.
- **Nginx Server**: A **web server** that runs on a Linux server, handling HTTP requests and serving static files.

---

## ⚙️ Some Key Directories in Nginx:

- **`/etc/nginx/nginx.conf`**: 
   - Main configuration file for Nginx.
   - All Nginx configurations (like port settings, server blocks) are managed here.
   - After making changes, you need to restart the Nginx service.

- **`/usr/share/nginx/html`**: 
   - The default directory where Nginx looks for HTML content.
   - You can place your HTML files here to be served by Nginx.

---

## 📡 DNS (Domain Name System)

- **What is DNS?**
   - DNS is a system that translates domain names (e.g., `facebook.com`) into IP addresses (e.g., `143.234.53.98`).
   - Without DNS, you would have to remember the IP addresses for all websites you visit.

### How DNS Resolution Works:

1. **User's Browser** (e.g., Chrome, Firefox):
   - Initiates a request to access a website.

2. **Local DNS Cache Check** (Browser / OS / Router):
   - The browser or OS checks its local cache for the IP address.

3. **DNS Resolver** (e.g., ISP or Public DNS):
   - If not cached, the request is sent to a DNS resolver (typically provided by your ISP or a public DNS service).

4. **Root DNS Server** (e.g., `.com`, `.org`):
   - The root server directs the query to the relevant TLD DNS server.

5. **TLD DNS Server** (e.g., `.com` TLD):
   - The TLD DNS server manages the top-level domains like `.com`, `.org`, etc.

6. **Authoritative DNS Server** (e.g., `example.com`):
   - The authoritative server has the actual DNS records for the domain and provides the final IP address.

7. **DNS Record (A, AAAA, MX)**:
   - The DNS record contains the actual IP address, mail exchange information, or other domain-specific data.

8. **Return IP to Resolver**:
   - The authoritative server returns the IP address to the DNS resolver.

9. **Cache IP Locally** (Browser / OS / Router):
   - The IP address is cached locally to speed up future requests.

10. **Browser Connects to IP**:
   - The browser uses the returned IP address to connect to the website.

---

### Key Terms in DNS Resolution:

- **DNS Resolver**: A server that converts domain names into IP addresses, typically provided by an ISP.
- **Root Server**: The first step in the DNS resolution process; it knows the TLD name servers.
- **TLD Server**: Handles domains that end in `.com`, `.net`, `.org`, etc., and points to authoritative servers.
- **Authoritative Server**: Contains the DNS records for a domain and returns the final IP address.
- **TTL (Time to Live)**: The duration for which DNS data is cached before a new lookup is required. Once the TTL expires, the DNS record is removed, and the data is looked up again.
- **Name Server**: A server that tells which entity is currently managing the domain.

---

## 📝 Types of DNS Records

1. **A Record (Address Record)**:
   - Maps a domain name to an IPv4 address.
   - Example: `example.com -> 192.0.2.1`

2. **AAAA Record (IPv6 Address Record)**:
   - Maps a domain name to an IPv6 address.
   - Example: `example.com -> 2001:0db8:85a3:0000:0000:8a2e:0370:7334`

3. **CNAME Record (Canonical Name Record)**:
   - Used to alias one domain name to another.
   - Example: `www.example.com -> example.com`

4. **MX Record (Mail Exchange Record)**:
   - Specifies mail servers responsible for receiving email for a domain.
   - Example: `example.com -> mailserver.example.com`

5. **TXT Record (Text Record)**:
   - Allows domain administrators to insert arbitrary text into the DNS record.
   - Often used for email validation or domain verification.
   - Example: `example.com -> "v=spf1 include:_spf.google.com ~all"`

6. **NS Record (Name Server Record)**:
   - Specifies authoritative DNS servers for a domain.
   - Example: `example.com -> ns1.example.com`

7. **PTR Record (Pointer Record)**:
   - Used for reverse DNS lookups; maps an IP address to a domain name.
   - Example: `1.2.3.4 -> example.com`

8. **SRV Record (Service Record)**:
   - Defines the location of a specific service (like SIP or LDAP).
   - Example: `_sip._tcp.example.com -> sipserver.example.com`

---

