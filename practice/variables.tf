# variable "ami" {
#   type = string
# }
# variable "instance_type" {
#   type = string
# }
# variable "tags" {
#   type = map(string)
# }

variable "EC2_AMI" {
  type    = string
  default = "ami-08665958117a3e86a"
}

variable "EC2_INSTANCE_TYPE" {
  type = string
  default = "t3.small"
  
}

variable "key_name" {
  type    = string
  default = "caresync"
}

# variable "app_name" {
#   description = "Name of the application"
#   type        = string
# }

# variable "vpc_id" {
#   description = "VPC ID"
#   type        = string
# }

variable "tags" {
  type = object({
    name      = string,
    project   = string,
    createdBy = string,
  })
  default = {
    name      = "Project-tf-datasource",
    project   = "Project-tf",
    createdBy = "Terraform"
  }
}