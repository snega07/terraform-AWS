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
