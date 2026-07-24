variable "primary_cidr" {
  type = string
  description = "Primary VPC CIDR"
}

variable "primary_subnet_cidr"{
  type = string
  description = "Primary subnet CIDR"
}

variable "tag" {
  type = map(string)
  description = "Tag to be added"
  default = {
    Purpose = "VPC-Peering"
  }
}

variable "vpc_id"{
  type = string
  description = "Primary VPC ID"
  default = ""
}

variable "peer_id" {
  type = string
  description = "Peer VPC ID"
  default = ""
}

variable "peer_region" {
  type = string
  default = "us-east-1"
}
