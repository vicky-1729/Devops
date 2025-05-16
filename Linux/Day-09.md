# DAY-09

## Project # 🤖 Roboshop
<img width="869" alt="Roboshop 3 Tier Architecture" src="https://github.com/user-attachments/assets/30519dc2-822f-4d0d-ae77-642dcf834040" />

---

`telnet <ip address> <port_no>`  
This checks if MySQL allows connections on that port.

`mysql -h <host-address> -u root -p<password>`  
This is usually how we connect to MySQL server.

`nslookup <ip>`  
Used to find which domain name is linked with an IP address.

`mysql_secure_installation --set-root-pass <password>`  
This sets the password for MySQL.

---

## Forward Proxy

Forward proxy works between your client and the internet.  
It forwards your requests to the server and sends back the response.

**Why use it?**  
- To hide your IP from the server  
- To monitor and control internet access  

**Common uses:**  
1. Block certain websites (content filtering)  
2. Monitor traffic  
3. Browse anonymously  
4. Bypass geo-restrictions  
5. Cache common stuff for faster loading  

**How it flows:**  
Client → Forward Proxy → Server

---

## Reverse Proxy

Reverse proxy works between the client and backend servers.  
It receives requests and forwards them to the right server.

**Why use it?**  
- To hide server identity from client  
- To improve performance and security  

**Common uses:**  
1. Load balancing  
2. SSL termination (handle HTTPS)  
3. Caching  
4. Protect backend servers  
5. Centralized access control  

**How it flows:**  
Client → Reverse Proxy → Backend Server

---

## Key Difference

- Forward Proxy hides the client from the server  
- Reverse Proxy hides the server from the client  

---

## HTTP Status codes

- 1XX → Information  
- 2XX → Success  
- 3XX → Redirection  

---

## Error Status codes

- 4XX → Client side error  
- 5XX → Server side error  

---

## Configuring Server

1. Create Linux server  
2. Install programming language and build tools  
3. Create dedicated directory for app — `/app`  
4. Create system user `roboshop`  
5. Download code into directory  
6. Install dependencies  
7. Create systemctl service  
8. Load data if needed  
9. Start the service  

---

## Trouble Shoot

Check if catalogue connects to MongoDB or not:  
`telnet <ip address> <port_no>`

For config changes:  
`systemctl restart <service_name>`

For system changes:  
`systemctl daemon-reloaded`

---

## Commands to check connection between backend and DB (DNS record & private IP)

`nslookup <dns record>`  
`telnet <dns record> <port_number>`

---

## Some interview questions / notes

- Maven build tool workflow?  
- Sync or async MQ?  
- Softlink vs hardlink?  
- inode → check with `stat file_name`
