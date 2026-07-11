variable "ami"{
    description = "EC2 instance AMI"
    default = "ami-0912f71e06545ad88"
    sensitive = true
}

variable "instance_type"{
    type = string
    description = "EC2 instance type"
}

variable "tags"{
    type = map(string)
    description = "Tags for the EC2 instance"
}