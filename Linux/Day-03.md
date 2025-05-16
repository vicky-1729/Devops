

## DAY-03

### Full Path vs Absolute Path & Basic Linux Commands

---

### 📂 Full Path vs Absolute Path

| Command Example                                                            | Explanation                                                 |
| -------------------------------------------------------------------------- | ----------------------------------------------------------- |
| `ssh -i /Users/ja20465253/Desktop/Demo/demokeypairs ec2-user@54.234.59.56` | Full Path — complete path to the key file specified         |
| `ssh -i demokeypairs ec2-user@54.234.59.56`                                | Absolute Path — assumes current directory contains key file |

---

### 🖥️ Terminal Prompts & Directories

| Prompt Symbol | Meaning              |
| ------------- | -------------------- |
| `$`           | Normal user          |
| `#`           | Root/admin/superuser |

| Directory | Description                      |
| --------- | -------------------------------- |
| `/root`   | Root user home directory         |
| `/`       | Root directory (filesystem base) |

---

### 📋 `ls` Command Variations (Listing files)

| Command   | Description                                 |
| --------- | ------------------------------------------- |
| `ls -l`   | Long listing format, alphabetical order     |
| `ls -lr`  | Long listing, reverse alphabetical order    |
| `ls -lt`  | Long listing, latest modified file on top   |
| `ls -ltr` | Long listing, latest file at bottom         |
| `ls -la`  | List all files including hidden (`.`) files |

---

### ✍️ File and Directory Management

| Command                | Description                                  |
| ---------------------- | -------------------------------------------- |
| `touch <file_name>`    | Create an empty file                         |
| `cat <file_name>`      | Display contents of a file                   |
| `cat > <file_name>`    | Write data to a file (overwrite)             |
| `cat >> <file_name>`   | Append data to a file                        |
| `mkdir <folder_name>`  | Create a directory                           |
| `rmdir <folder_name>`  | Remove an empty directory                    |
| `rm -f <file_name>`    | Force remove a file                          |
| `rm -rf <folder_name>` | Recursively force delete folder and contents |

---

### 🔄 CRUD Operations (Create, Read, Update, Delete)

| Command                     | Description                     |
| --------------------------- | ------------------------------- |
| `cp <source> <destination>` | Copy files or folders           |
| `mv <source> <destination>` | Move or rename files or folders |

---

### 🌐 Downloading Files

| Command                       | Description                       |
| ----------------------------- | --------------------------------- |
| `wget <url>`                  | Download file from URL            |
| `curl <url>`                  | Show content of URL on screen     |
| `curl -o <destination> <url>` | Download file to specified folder |

---

### 🔍 Searching Inside Files

| Command                               | Description                      |
| ------------------------------------- | -------------------------------- |
| `cat <file> \| grep <word>`           | Search for a word inside a file  |
| Example: `cat demo.txt \| grep error` | Finds "error" word in `demo.txt` |

---

### 🛠️ AWK Command (Text processing)

```bash
echo <url> | awk -F "/" '{print $1F}'
```

* `-F "/"` defines `/` as delimiter
* Prints the specified field (columns split by `/`)

---

### 📄 Viewing Parts of Files

| Command      | Description  |                                 |
| ------------ | ------------ | ------------------------------- |
| \`cat <file> | head\`       | Show top 10 lines of a file     |
| \`cat <file> | head -n 10\` | Show top *n* lines (here 10)    |
| \`cat <file> | tail\`       | Show bottom 10 lines            |
| \`cat <file> | tail -n 10\` | Show bottom *n* lines (here 10) |

---

### 📜 Viewing Logs

```bash
tail -f <logfile>
```

* Shows the latest lines of a logfile and keeps updating live as new lines are added.

---

### 🔎 Find Files

```bash
find <where_to_search> -name <file_name>
```

* Searches for files by name in specified directory and its subdirectories.


