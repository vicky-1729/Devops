
## DAY-06

### Process Management & Network Management & 3-Tier Architecture

---

### Process Management

---

* Process means a running program in Linux.
* To see processes, usually you need **sudo** or **root** access.
* Like in a software team:
  Team\_Manager → Team\_Lead → Senior\_Member → Junior → Trainee
* In Linux, when you run a command like `ls -ls`, this happens:

Process is created  
↓  
Processor assigns a **Process ID (PID)**  
↓  
Command runs inside the **kernel**  
↓  
Output is generated  
↓  
Output is shown on your screen  



---

#### Useful Commands

| Command                 | Description                           | Example/Note                           |               |
| ----------------------- | ------------------------------------- | -------------------------------------- | ------------- |
| `ps`                    | List currently running processes      | `ps`                                   |               |
| `ps -ef`                | List all processes in detail          | Shows columns like UID, PID, PPID, CMD |               |
| `ps -ef \| grep <name>` | Search for a specific process by name | \`ps -ef                               | grep python\` |

* **PID** = Process ID
* **PPID** = Parent Process ID (which started this process)

---

#### Check if Process is Running

```bash
ps -ef | grep <process-name>
```

---

#### Foreground vs Background Process

| Type               | Description                         | Example      |
| ------------------ | ----------------------------------- | ------------ |
| Foreground Process | Runs and blocks terminal until done | `sleep 10`   |
| Background Process | Runs in background, terminal free   | `sleep 10 &` |

---

#### Kill Processes

| Command       | Description                    | Output               |
| ------------- | ------------------------------ | -------------------- |
| `kill PID`    | Request process to terminate   | Shows **Terminated** |
| `kill -9 PID` | Force kill process immediately | Shows **Killed**     |

---

#### Monitor Specific Process

```bash
top -p <PID>
```

* Shows resource usage (CPU, memory) of the specific process

---

### Network Management

---

* To check **open ports** on Linux:

```bash
netstat -lntp
```

* Flags explained:

  * `l` = list listening ports
  * `n` = show port numbers numerically
  * `t` = show TCP ports
  * `p` = show process using the port

---

### DNS & Connectivity Tools
| Command                      | Purpose                            | Example                         |
|------------------------------|----------------------------------|---------------------------------|
| `nslookup <website-url>`     | Get IP or DNS records for a domain | `nslookup google.com`           |
| `systemctl status <service>` | Check status of a Linux service  | `systemctl status sshd`         |
| `netstat -lntp`              | Check open ports                 | `netstat -lntp`                 |
| `top -p <PID>`               | Check resource usage by process  | `top -p 1234`                   |
| `telnet <ip> <port>`         | Test connectivity to IP and port | `telnet 192.168.1.10 80`        |
| `telnet <dns> <port>`        | Test connectivity to DNS and port| `telnet google.com 80`          |
| `ps -ef \| grep <service>`   | Check if service process is running | `ps -ef \| grep sshd`           |

---

### 3-Tier Architecture

---

The 3-tier architecture divides a web application into three separate layers, each with a clear role to improve scalability, maintainability, and security.

### 1. Presentation Layer (Frontend)

- This is the user interface layer where users interact with the application, such as through web browsers or mobile apps.
- It handles displaying data and capturing user inputs.
- Communicates with the backend using APIs to send/receive data.

### 2. Application Layer (Backend)

- Contains the core business logic of the application.
- Processes requests from the frontend and applies business rules.
- Manages workflows, authentication, authorization, and error handling.
- Interacts with the database layer to fetch or store data.

### 3. Database Layer

- Responsible for persistent data storage.
- Typically uses relational databases (e.g., MySQL, PostgreSQL) or NoSQL databases.
- Accessed only through the backend layer to ensure security and data integrity.

---

### Why Use 3-Tier Architecture?

- It keeps things clean by splitting the app into parts that do different jobs.
- Different teams can work on each part without getting in each other’s way.
- The database is safe because only the backend can talk to it.
- You can make each part bigger or smaller depending on how many people use the app.

* Each layer is separate for scalability, security, and easy maintenance
<img width="879" alt="Screenshot 2025-05-05 at 10 13 03 PM" src="https://github.com/user-attachments/assets/01d40c6a-7de2-4066-bc15-c2b72814a249" />

