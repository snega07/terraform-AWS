terraform init
- Initializes the Terraform working directory.
- Downloads the required provider plugins.
- Downloads and initializes child modules.
- Configures the backend (if configured).
- Does NOT configure cloud provider credentials. Terraform reads credentials from provider configuration, environment variables, AWS CLI profile, etc.

terraform validate
- Validates the Terraform configuration syntax and internal consistency.
- Checks for missing arguments, invalid references, and unsupported attributes.
- Does NOT contact the cloud provider.

terraform plan
- Creates an execution plan (dry run).
- Refreshes the Terraform state by comparing it with the actual infrastructure (unless -refresh=false is used).
- Connects to the cloud provider API.
- Shows what resources will be created, updated, or destroyed.
- Does NOT make any infrastructure changes.

terraform apply
- Executes the changes shown in the execution plan.
- Creates, updates, or deletes infrastructure.
- Updates the Terraform state file after successful changes.

terraform refresh (deprecated as a standalone command)
- Refreshes the Terraform state file with the current state of the infrastructure.
- Reads the actual resource information from the cloud provider.
- Does NOT modify infrastructure.
- This functionality is automatically performed during terraform plan and terraform apply.

terraform output
- Displays the values of output variables.
- Reads the values from the Terraform state file.