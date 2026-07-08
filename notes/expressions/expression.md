### Conditional Expression

Assign values based on the condition. If true left value will assigned. If the condition become false right value will be assigned.

resource argugement = condition ? true:false
``` hcl
Example:
instance_type = var.env=='dev' ? "t2.micro":"t3.micro"

```
Use case:

- Assigning different instance types based on environment (dev, staging, production).
- Select different AMI based on region
- Set different resource count for environment.

### Dynamic block

Dynamic block will make us to pass the list of values for a arguement in a resource. 

``` hcl
resource "aws_security_group" "web" {

  dynamic "ingress" {

    for_each = var.ports

    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```
Use for_each when you want multiple resources, modules, or data sources.
Use dynamic when you want multiple nested blocks inside a single resource.

| Feature | `for_each`                             | `dynamic` block                                                  |
| ------- | -------------------------------------- | ---------------------------------------------------------------- |
| Purpose | Create multiple resources (or modules) | Create multiple nested configuration blocks inside one resource  |
| Creates | Multiple resource instances            | Multiple nested blocks within a single resource                  |
| Used on | `resource`, `module`, `data`           | Nested blocks like `ingress`, `egress`, `ebs_block_device`, etc. |
| Result  | Many resources                         | One resource with many nested blocks                             |

### Splat expression

A splat expression in Terraform is a shorthand syntax used to collect the same attribute from multiple resources or objects. Instead of writing a loop yourself, Terraform extracts the attribute from every element in a list.

resource[*].attribute

It is equivalent to:
[for item in resource : item.attribute]

Example:

``` bash
Example 1: Get Public IPs of Multiple EC2 Instances

Suppose you created multiple EC2 instances using count.

resource "aws_instance" "server" {
  count         = 3
  ami           = "ami-12345"
  instance_type = "t2.micro"
}

Without a splat expression:

output "ips" {
  value = [
    aws_instance.server[0].public_ip,
    aws_instance.server[1].public_ip,
    aws_instance.server[2].public_ip
  ]
}

Using a splat expression:

output "ips" {
  value = aws_instance.server[*].public_ip
}

Output:

[
  "54.10.10.1",
  "54.10.10.2",
  "54.10.10.3"
]


```