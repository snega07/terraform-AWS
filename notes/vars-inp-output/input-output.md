## Input

Inputs are dynamic values passed into a Terraform configuration or module using input variables. They make the configuration reusable by allowing different values to be supplied without modifying the code.

**Input variables** → Bring data into a module.
**Outputs** → Send data out of a module.

## Output

Outputs expose values from a Terraform configuration or module. They are commonly used to:

- Display useful information after terraform apply.
- Pass values from a child module to its parent module.
- Share resource attributes (such as IDs, ARNs, IP addresses, DNS names, etc.) with other Terraform configurations or automation.

- Similar to variable. We can declare output and take values from created resoirce and pass down to parent modules. 
- This helps to display required details once the resource got created.
- If a child module output is marked sensitive = true and the parent module exposes that output again, the parent output must also be marked sensitive = true. Otherwise, Terraform throws an error.

**Usecases:**

Sensitive outputs are used to securely pass secret values between Terraform modules or resources while preventing those values from being displayed in CLI output and logs. They hide the value from users but still allow Terraform to consume it internally.

- Pass a database password from an RDS module to a Secrets Manager module.
- Pass an API key or access token from one module to another.
- Pass a private key or certificate to another resource that needs it.
- Expose a secret for automation (another Terraform configuration or CI/CD pipeline can consume it) - while preventing it from appearing in terraform plan or terraform apply output.
