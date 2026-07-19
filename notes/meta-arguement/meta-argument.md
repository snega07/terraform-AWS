## Meta Arguement

There is lots of optional and required argument that we can pass while creating resource in terraform. Terraform itself provide some in-build arguments that creates, scales and manage resources.

They are supported my all the providers and regardless of the resource we creates.


## Depends On

**Purpose:** Explicitly defines structural dependencies between resources when Terraform cannot automatically infer them.
Terraform by default use implicit dependecy graph while creating resources. Based on the other resources ID or values we pass in the resource configuration. 
**Usage:** Forces Terraform to complete all actions on a prerequisite resource before configuring the dependent resource.
**Example:** Ensuring an IAM Role policy is fully attached before launching an application instance that uses it

## Count

**Purpose:** Provisions a specific number of identical infrastructure objects.
**Usage:** Accepts a whole number. You can use the count.index variable to uniquely name or configure each instance.
**Example:** Creating 3 web servers using a single code block.

## For each

**Purpose:** Creates multiple resource instances mapped to the items of a specific set or map.**Usage:** Safer and more flexible than count for dynamic scaling, as it tracks resources by keys rather than numeric array indexes.
**Note:** count and for_each are mutually exclusive; you cannot use both in the same block.

for_each > each.key, each.value

## Provider and Providers

**Purpose:** Specifies an alternate configuration for a resource or module when using multiple provider blocks.
**Usage:** Ideal for multi-region or multi-account deployments.
**Example:** Deploying one database in us-east-1 and a backup database replica in us-west-2.

| `provider`                       | `providers`                              |
| -------------------------------- | ---------------------------------------- |
| Defines or configures a provider | Maps provider configurations to a module |
| Used in the root module          | Used inside a `module` block             |
| Singular                         | Plural                                   |

The providers argument is used inside a module block to tell the module which provider configuration to use.

The module expects an aws provider.
Instead of the default provider, you're passing the aliased provider aws.us.
``` hcl
Complete Example
provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  alias  = "us"
  region = "us-east-1"
}

module "india" {
  source = "./modules/ec2"

  providers = {
    aws = aws
  }
}

module "usa" {
  source = "./modules/ec2"

  providers = {
    aws = aws.us
  }
}
```
## Lifecycle rules

**Purpose:** A nested configuration block that overrides Terraform's standard behavior during updates and deletions.
**Key settings:**
**create_before_destroy:** Avoids downtime by launching a new resource variant prior to deleting the old one.
**prevent_destroy:** Protects critical resources (like production databases) from accidental deletion.
**ignore_changes:** Stops Terraform from overwriting external configuration changes made directly in the cloud console

| Feature           | `count`                                  | `for_each`                                           |
| ----------------- | ---------------------------------------- | ---------------------------------------------------- |
| Input             | Number (integer)                         | Map or Set of strings                                |
| Resource indexing | Numeric (`[0]`, `[1]`)                   | Key-based (`["web"]`, `["db"]`)                      |
| Best for          | Identical resources                      | Resources with unique names/configurations           |
| Stability         | Less stable when items are added/removed | More stable because resources are identified by keys |
