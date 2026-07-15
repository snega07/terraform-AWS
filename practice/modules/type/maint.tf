resource "aws_instance" "example" {
  for_each               = var.EC2_INSTANCE_TYPE
  ami                    = var.EC2_AMI
  instance_type          = each.value
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  depends_on = [aws_security_group.allow_ssh]


  tags = {
    Name = each.key
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  depends_on = [aws_security_group.allow_ssh]

}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}