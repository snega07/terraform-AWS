List:
Imagine you're creating EC2 instances.
subnet_ids = [
  "subnet-1",
  "subnet-2",
  "subnet-3"
]

order matters-> subnet AZ, cmd orders-> like nginx install
EC2 sg -> order doesn't matter, if we are attaching more than 1 seciryt group.

Three subnet IDs in order.
create subnets in multiple Availability Zones.

variable "availability_zones" {
  type = list(string)

  default = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c"
  ]
}

Set:

Security Groups

Suppose someone accidentally enters duplicate security groups.

variable "sg_ids" {
  default = [
    "sg-111",
    "sg-222",
    "sg-111"
  ]
}

Convert to a set:

locals {
  unique_sgs = toset(var.sg_ids)
}

Map: Different environments need different AMIs.

Object: An object is like a class or struct. It groups related attributes, and those attributes can have different types.
Instead of passing many separate variables:

instance_name
instance_type
disk_size
monitoring

you pass one object:

ec2 = {
  name          = "web"
  instance_type = "t3.micro"
  volume_size   = 20
  monitoring    = true
}

Tuple -> rarely used
[
  "frontend",
  2,
  true
]

This works, but it's not very clear what each position means

