## State File

- State file is terraform proof of work. Whenever we do changes in the resource creation configuration, post apply it stores the state of resources it created. 
- During terraform plan, Terraform compares the desired configuration with the current state (using the state file and refreshing from the provider) to determine what changes are required.
- During the first terraform apply, Terraform creates the resources by calling the cloud provider APIs and then generates the state file.
- The state file tells Terraform what it previously created. Terraform also queries the cloud provider (unless refresh is disabled) to detect drift before producing the plan.

## Best practice

**Remote Backend**

- Since actual resource creation mainly depends on this state file. It must be stored in a secured and protected corruption free place.
- We can configure a remote backend such as Amazon S3, Azure Blob Storage or Google Cloud Storage to securely store the Terraform state.
- Also this file has resource realted sensitive information it must be stored in a secured file.
Terraform state may contain
• Resource IDs
• Public IPs
• Database endpoints
• IAM ARNs
• Secrets (depending on provider/resource)

- If the file get corrupted this cause bigger impact on our infrastructure.

**Update/Delete**

- tfstate file must not be deleted. This act as a memory of terraform on whats the current state of infrastructure. All the modification or deletion decison will be taken using this file.
Deleting the state file does not delete infrastructure.
- Deleting the state file does not delete infrastructure. Instead it causes Terraform to lose track of the resources. That means the next apply may try to recreate existing resources.

**Lock**

- When storing the file in remote backend. We must make sure that this file won't be modified by more than one person at a time. Otherwise this will cause inconsisteny in the infrastructure.
- Lock will be acheived using dynamoDB or terraform feature called lockfile in S3.
- **Lockfile:** Conditional check implemented by tf, it will create a temprory lock file named "terraform.tfstate.tflock" when we do apply and post comlition of the work tf will delete this file. 
- Terraform attempts to create a temporary terraform.tfstate.tflock object. If the object already exists, another Terraform operation holds the lock, and Terraform aborts with a state lock error.

**DynamoDB**

- Terraform uses a DynamoDB table to implement state locking (older approach before use_lockfile).
- When terraform apply starts, Terraform sends a conditional PutItem request to DynamoDB.
- A lock record is created only if the LockID does not already exist.
- If the lock is created successfully, Terraform owns the lock and proceeds with the operation.
- If another user has already acquired the lock, DynamoDB returns ConditionalCheckFailedException, and Terraform aborts with "Error acquiring the state lock".
- After the operation completes successfully (or the lock is released), Terraform sends a DeleteItem request to remove the lock record.
- This ensures that only one Terraform operation can modify a particular state file at a time, preventing state corruption.

Flow:

terraform apply
      │
      ▼
Conditional PutItem (LockID)
      │
      ├── Success → Acquire lock → Apply changes → Delete LockID
      │
      └── Failed (LockID exists) → State lock error

**Isolation(DEV, UAT, PROD)**

- It better to use different state file based on environment.
- Large companies usually prefer separate state files (or separate backends) for each environment because it provides better isolation.

Method 1

dev.tfstate
uat.tfstate
prod.tfstate

(Preferred)

OR

Terraform Workspaces

**Backup**

- We have to make surte to take backup of the tfstate file. To make sure incase any unexpected deletion of this file we can get backup. This will be achieved by enabling versioning in S3.

**State file sharing**

Never edit terraform.tfstate manually. Terraform expects the file to remain consistent.

Manual edits can lead to:

orphaned resources
duplicate resources
incorrect plans
state corruption

Instead use Terraform commands such as:

terraform state list
terraform state mv
terraform state rm
terraform import