resource "aws_instance" "example" {
  # for_each               = var.EC2_INSTANCE_TYPE
  ami                    = var.EC2_AMI
  instance_type          = var.EC2_INSTANCE_TYPE
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  depends_on = [aws_security_group.allow_ssh]
  subnet_id = var.subnet_id


  tags = var.tags
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