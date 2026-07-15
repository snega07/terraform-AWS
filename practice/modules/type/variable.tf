variable "EC2_AMI" {
  type        = string
  description = "The AMI to use for the EC2 instance"
  # default = "ami-08665958117a3e86a"
}

variable "EC2_INSTANCE_TYPE" {
  type        = map(string)
  description = "The instance type to use for the EC2 instance"
  # default = {
  #     APP_Server = "t3.small"
  #     ELK = "t3.small"
  # }
}

variable "key_name" {
  type        = string
  description = "The name of the key pair to use for the EC2 instance"

}

variable "tags" {

  type = object({
    name      = string,
    project   = string,
    createdBy = string,
  })
  description = "A map of tags to assign to the resource"
  default = {
    name      = "Project-tf",
    project   = "Project-tf",
    createdBy = "Terraform"
  }

}
