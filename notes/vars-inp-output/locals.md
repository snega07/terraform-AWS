## Local

- Locals are used to define named values that can be reused within a Terraform module. They help avoid repeating the same expression multiple times and make the configuration easier to read and maintain.
- Variables cannot reference other variables in their default values. If you need to derive a value by combining variables or expressions, use a local value.

**A local value can be created using:**

Variables
Resource attributes
Functions
Expressions
Other local values

Unlike input variables, local values cannot be overridden by users.

**Why use locals?**

- Combine multiple variables into a single value.
- Avoid repeating the same expression multiple times (DRY principle).
- Improve readability and maintainability.
- Compute derived values from variables or resources.
- Store values that are used only within the current module.

``` hcl
Combine variables

variable "environment" {}
variable "application" {}

locals {
  name = "${var.environment}-${var.application}"
}

Use:

tags = {
  Name = local.name
}
```