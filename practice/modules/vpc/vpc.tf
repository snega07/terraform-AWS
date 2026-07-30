# Creating  VPC, subnet, RTB, Routes and peering primary to secondary
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {
    vpc_tag = merge({Name="VPC-peering"},var.tag)
    subnet_tag = merge({Name="${data.aws_region.current.region}-Subnet"},var.tag)
    IGW_tag = merge({Name="${data.aws_region.current.region}-IGW"},var.tag)
    route_table_tag = merge({Name="${data.aws_region.current.region}-Route-Table"},var.tag)
}

resource "aws_vpc" "vpc_main" {
  cidr_block       = var.primary_cidr
  instance_tenancy = "default"

  tags = local.vpc_tag
}

resource "aws_subnet" "primary" {

  vpc_id                  = aws_vpc.vpc_main.id
  cidr_block              = var.primary_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = local.subnet_tag
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.vpc_main.id
    tags = local.IGW_tag
}

resource "aws_route_table" "rtb-main" {
  vpc_id = aws_vpc.vpc_main.id

  tags = local.route_table_tag
}

resource "aws_route" "igw_route" {
  route_table_id         = aws_route_table.rtb-main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "example" {
  subnet_id      = aws_subnet.primary.id
  route_table_id = aws_route_table.rtb-main.id
}
