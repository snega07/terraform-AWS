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
  type = map(string)
  default = {
    APP_Server = "t3.small"
    ELK        = "t3.small"
  }
}

variable "key_name" {
  type    = string
  default = "caresync"
}