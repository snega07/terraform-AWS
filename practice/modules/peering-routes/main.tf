resource "aws_route" "rtb" {
  route_table_id            = var.rtb_id
  destination_cidr_block    = var.cidr
  vpc_peering_connection_id = var.vpc_peeringID
}