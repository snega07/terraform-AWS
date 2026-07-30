variable "ami"{
    type= string
}

variable "instance_type"{
    type= string
}

variable "subnetId"{
    type= string
}

variable "key_name" {
  type = string
}

variable "tag" {
  type = map(string)
}

variable "ingress_map" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "vpc_ID"{
    type = string
}

variable "vpc_cidr"{
  type = string
}