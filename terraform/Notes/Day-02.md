# Terraform Variable Precedence and Loops

When creating resources in Terraform, outputs from one resource can be passed to another for building dependencies.

## Variable Precedence (Highest to Lowest)

1. **Command Line**  
   Syntax: `terraform apply -var="name=value"`

2. **terraform.tfvars File**  
   Syntax in file: `name = "value"`

3. **Environment Variable**  
   Syntax: `export TF_VAR_name="value"`

4. **Variables File (Default Value)**  
   Syntax:
   ```hcl
   variable "name" {
     default = "value"
   }
   ```

5. **User Prompt**  
   No syntax; Terraform will prompt for the value if not set above.

---

## Loops in Terraform

1. **Count-based Loop**
   - Use when you have a list of items.


2. **For Loop**
   - Used for transforming or filtering lists/maps.
  

3. **Dynamic Block**
   - Use for generating nested blocks dynamically.
  

**Tip:**
- Use `count` for lists.
- Use `for_each` for maps or sets.