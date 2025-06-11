GitHub Copilot
Your notes are clear and well-structured! Here’s a slightly refined and concise version for easy reference or documentation:

# Terraform State File – Simple Explanation

**IaaC (Infrastructure as Code):** Declarative way to create infrastructure. You declare what you want in `.tf` files, and Terraform creates it if the syntax is correct.

**Expectation vs. Reality:**
- `.tf` files = your desired infrastructure (**expectation**)
- Actual resources in AWS (or other provider) = **reality**
- **State file** = how Terraform tracks what it has created

**How Terraform Uses the State File**

**First Run (`terraform plan`):**
- Reads `.tf` files (what you want)
- Reads state file (empty at first)
- Checks provider (AWS, etc.) for existing resources
- If resources don’t exist, creates them and updates the state file

**Subsequent Runs:**
- Reads `.tf` files and state file
- Checks provider to confirm resources exist
- If everything matches, **no changes are needed**

**Manual Changes in Provider:**
- If you delete a resource manually (e.g., via AWS console), the state file and `.tf` files still think it exists
- Terraform detects the mismatch and plans to **recreate** the missing resource

**Changing `.tf` Code:**
- If you remove a resource from `.tf` files, but it still exists in the state file and provider, Terraform will plan to **destroy** it

**Why the State File Matters**
- Tracks what Terraform manages
- Compares desired state (`.tf` files) with actual state (provider) using the state file
- Ensures **safe and predictable changes**

**Problem with Local State File**
- Local state file works for a **single user**
- In a team, each person’s local state can get out of sync
- Can cause **duplicate resources or errors**
- **Solution:** Use a remote backend (like S3) for shared state in teams

---

### **dynamic block**
--------------
- Used to generate multiple nested blocks inside a resource  
- Works based on a variable or collection (like list or map)  
- Helps avoid hardcoding repeated blocks  
- Makes configuration flexible, reusable, and clean  
- Example: creating multiple `ingress` rules in a security group using a loop  

---

### **builtin functions**
------------------
- We can’t create custom functions in Terraform  
- But we can use built-in functions provided by Terraform  
- Functions take input → transform into desired output  
- Examples:  
  - `length(var.list)` → gives number of items  
  - `join("-", var.tags)` → joins list with `-`  
  - `lookup(map, key, default)` → fetches value from map  

---

### **data sources**
------------
- Used to fetch data dynamically from the provider  
- No need to hardcode values manually  
- Example: instead of giving AMI ID manually, it fetches the latest AMI from AWS  
- Keeps infrastructure dynamic and always up to date  
- Data sources are read-only → used only to get info, not to create resources  

---

### **locals**
-------
- Locals are more powerful than variables  
- You can assign expressions and functions to locals  
- Use them wherever needed in your config  
- Locals are fixed once defined → can’t be overridden like variables  

#### Summary:
- Locals can have expressions  
- You give a name and use it wherever needed  
- Locals are like variables, they hold values with keys  
- Inside locals, you can use variables, expressions, functions  
- Variables can be overridden, but locals can’t be overridden
