## ⚙️ Process Management

- **Purpose**: Used to monitor and manage processes on the system.
- **Run as root or sudo user** to manage processes.

### Process Workflow Example:

In a software team, the workflow might look like this:
- Team_Manager → Team_Lead → Senior_Member → Junior → Trainee

In Linux, when you run a command, several processes happen in the background:
1. **Process Creation** (e.g., `ls -ls`)
2. **Assign Processor ID (PID)**
3. **Execute commands in kernel**
4. **Get Output**
5. **Show on Display**

### Commands to Manage Processes

#### `ps`
- Lists the processes currently running on the system.
  
```bash
ps -ef
```

Output example:

```text
UID        PID  PPID  C STIME TTY       TIME        CMD
root        1     0    0 2023   ?        00:00:05 /sbin/init
user        1105  1    0 2023   ?        00:00:10 /usr/bin/python3
user        1234  1105 0 2023   pts/0     00:00:00 /bin/bash
```

Where:
- **PID** = Process ID
- **PPID** = Parent Process ID (ID of the process that started this one)

#### Check if a process is running:

```bash
ps -ef | grep <process-name>
```

#### Process Types:

1. **Foreground Process**:
   - If you run this, you cannot do anything else until it finishes.
   
2. **Background Process**:
   - Runs in the background. You can continue working with other commands.

To run a command in the background, use `&`:

```bash
sleep 10
sleep 10 &
```

#### Kill a Process:

- To request termination:
  
  ```bash
  kill <PID>
  ```

- To forcefully terminate:

  ```bash
  kill -9 <PID>
  ```

#### `top` Command:

- Use to check CPU and memory usage by processes:

```bash
top -p <PID>
```

---

## 🌐 Network Management

### Check Open Ports

- To see which ports are open on your system:

```bash
netstat -lntp
```

Where:
- `l` = List open ports
- `n` = Show port numbers
- `t` = Show TCP connections
- `p` = Show the process using the port

### DNS Lookup

- To find the IP address of a domain:

```bash
nslookup <website-url>
```

Example:

```bash
Server: 172.31.0.2
Address: 172.31.0.2#53
```

### Troubleshooting Commands

To troubleshoot any application, you can use these basic commands:

1. **Check the service status**:

```bash
systemctl status <service-name>
```

2. **List running processes**:

```bash
ps -ef | grep <service-name>
```

3. **Check open ports**:

```bash
netstat -lntp
```

4. **Check resource usage by PID**:

```bash
top -p <PID>
```

---

## 🏛️ 3-Tier Architecture

(You can add specific details about 3-Tier architecture here, if required)
