
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
