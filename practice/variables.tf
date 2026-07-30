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

variable "ingress_map" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = {
    ssh = {
      description = "SSH from anywhere"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    http = {
      description = "HTTP from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
    https = {
      description = "HTTPS from anywhere"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
  }
}

variable "ingress_map2" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = {
    ssh = {
      description = "SSH from anywhere"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    http = {
      description = "HTTP from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["10.1.0.0/16"]
    }
    https = {
      description = "HTTPS from anywhere"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["10.1.0.0/16"]
    }
  }
}


