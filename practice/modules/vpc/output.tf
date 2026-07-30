output "VPC_ID"{
    value = aws_vpc.vpc_main.id
}

output "RTB_ID" {
    value = aws_route_table.rtb-main.id
}

output "subnet_ID"{
    value = aws_subnet.primary.id
}