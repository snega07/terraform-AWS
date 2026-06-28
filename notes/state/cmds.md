**Easy way to remember**

list → "What resources does Terraform know about?"
show → "Show me one resource's stored attributes."
pull → "Download and display the complete state file."
rm → "Forget this resource, but don't delete it."
mv → "Rename or move a resource in Terraform's memory."


**Terraform state list:**

Lists all resources that Terraform is currently tracking in the state.

``` bash
terrafrom state list
```

**Terraform state show:**

Shows the complete details of one resource stored in the state.

``` bash
Syntax:

terraform state show <RESOURCE_ADDRESS>
```

**Terraform state pull**

Downloads and prints the entire state file.
``` bash
terraform state pull
```

**Terraform state rm**

Removes a resource from the state file only.

``` bash
Syntax:

terraform state rm aws_instance.web

```
Common use cases:

- Stop managing an existing resource without deleting it.
- Recover from state issues.
- Move a resource to another state.

**Terraform state mv**

Moves or renames a resource within the state. No infra changes occur just rename.

Example:
``` bash
terraform state mv aws_instance.web aws_instance.frontend
```

Before:
resource "aws_instance" "web" {}

Later you rename it:
resource "aws_instance" "frontend" {}


