
## DAY-04

### VIM Editor & Linux User Management

---

### 📝 VIM Editor Basics

| Command           | Description                         |
| ----------------- | ----------------------------------- |
| `vim <file_name>` | Open or create a file in vim editor |

---

### 🔄 VIM Modes

| Mode            | Description                      | How to enter            |
| --------------- | -------------------------------- | ----------------------- |
| **Esc Mode**    | Default mode for commands        | Press `Esc`             |
| **Insert Mode** | For typing/editing content       | Press `i` from Esc mode |
| **Colon Mode**  | Command mode to run vim commands | Press `:` from Esc mode |

---

### ⌨️ Basic VIM Commands (Command Mode)

| Command       | Description                                     |
| ------------- | ----------------------------------------------- |
| `:q`          | Quit vim                                        |
| `:q!`         | Quit without saving                             |
| `:wq`         | Write (save) and quit                           |
| `:wq!`        | Force write (save) and quit (override readonly) |
| `:/<word>`    | Search `<word>` from top down                   |
| `:?<word>`    | Search `<word>` from bottom up                  |
| `:noh`        | Remove search highlight                         |
| `:set nu`     | Show line numbers                               |
| `:<number> d` | Delete specific line                            |
| Example: `3d` | Delete line 3                                   |

---

### 🔄 Find and Replace in VIM

| Command                            | Description                                    |
| ---------------------------------- | ---------------------------------------------- |
| `:<number>s/<target>/<new_word>`   | Replace first occurrence on that line          |
| Example: `3s/vicky/vsvicky`        | Replace first "vicky" with "vsvicky" on line 3 |
| `:<number>s/<target>/<new_word>/g` | Replace all occurrences on that line           |
| Example: `3s/vicky/vsvicky/g`      | Replace all "vicky" with "vsvicky" on line 3   |
| `:%s/<target>/<new_word>/g`        | Replace all occurrences in entire file         |
| Example: `%s/vicky/vsvicky/g`      | Replace all "vicky" with "vsvicky" in file     |

---

### ⌨️ Esc Mode (Navigation & Editing)

| Command     | Description               |
| ----------- | ------------------------- |
| `u`         | Undo last change          |
| `yy`        | Copy (yank) current line  |
| `p`         | Paste copied line         |
| `dd`        | Cut (delete) current line |
| `gg`        | Go to top of the file     |
| `Shift + G` | Go to bottom of the file  |

---

### 👥 Linux User Management

---

### User & Group Basics

| Term            | Description                             |
| --------------- | --------------------------------------- |
| User            | Individual system account               |
| Group           | Collection of users with similar access |
| Primary Group   | Main group assigned to user at creation |
| Secondary Group | Additional groups user can be added to  |

---

### User Commands

| Command                  | Description                  |
| ------------------------ | ---------------------------- |
| `useradd <user_name>`    | Create a new user            |
| Example: `useradd vicky` | Creates user named `vicky`   |
| `id <user_name>`         | Check user ID and group info |
| `passwd <user_name>`     | Set or change user password  |
| `userdel <user_name>`    | Delete user                  |

---

### Group Commands

| Command                 | Description              |
| ----------------------- | ------------------------ |
| `groupadd <group_name>` | Create a new group       |
| Example: `groupadd vs`  | Creates group named `vs` |
| `groupdel <group_name>` | Delete a group           |

---

### Modify User Group Membership

| Command                                     | Description                                     |
| ------------------------------------------- | ----------------------------------------------- |
| `usermod -g <group_name> <user_name>`       | Change user’s **primary** group                 |
| Example: `usermod -g vs vsvicky`            | Set `vs` as primary group for `vsvicky`         |
| `usermod -aG <group_name> <user_name>`      | Add user to **secondary** group                 |
| Example: `usermod -aG secondary_gp vsvicky` | Add `vsvicky` to secondary group `secondary_gp` |

---

### SSH Login

| Command                                | Description                                     |
| -------------------------------------- | ----------------------------------------------- |
| `ssh <user_name>@<public_ip>`          | SSH login to remote server as user              |
| Example: `ssh vsvicky@123.77.635.7637` | Login as user `vsvicky` to IP `123.77.635.7637` |

---

### SSH Configuration File

| File Path              | Description                   |
| ---------------------- | ----------------------------- |
| `/etc/ssh/sshd_config` | SSH server configuration file |

