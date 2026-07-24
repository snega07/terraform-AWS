
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.requester,
        aws.accepter
      ]
    }
  }
}
resource "aws_vpc_peering_connection" "primary-to-secondary" {
  provider = aws.requester
  peer_vpc_id   = var.peer_id
  vpc_id        = var.vpc_id
  peer_region   = data.aws_region.accepter.region
  auto_accept = false

  tags = local.vpc-con-tags

  lifecycle {
    ignore_changes = [peer_region]
  }
}
resource "aws_vpc_peering_connection_accepter" "primary-to-secondary" {
  provider = aws.accepter
  vpc_peering_connection_id = aws_vpc_peering_connection.primary-to-secondary.id
  auto_accept               = true

  tags = local.con-acceptor-tag
}


locals {
  vpc-con-tags = merge({name="${data.aws_region.requester.region}"},var.tag)
  con-acceptor-tag = merge({name="${data.aws_region.accepter.region}"},var.tag)
}