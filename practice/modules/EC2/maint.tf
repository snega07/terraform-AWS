resource "aws_instance" "secondary_instance" {

  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnetId
  vpc_security_group_ids      = [aws_security_group.primary_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  lifecycle {
    replace_triggered_by = [terraform_data.replace]
  }
  user_data = local.user_data

  tags = local.tag

}

resource "terraform_data" "replace" {
  input = "force-replace"
}

locals {
    user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y apache2
    systemctl start apache2
    systemctl enable apache2
    echo "<h1>Primary VPC Instance - ${data.aws_region.current.region}</h1>" > /var/www/html/index.html
    echo "<p>Private IP: $(hostname -I)</p>" >> /var/www/html/index.html
    EOF

    tag = merge( {Name = "EC2-peering-sample - ${data.aws_region.current.region}"}, var.tag)
       
    
}

resource "aws_security_group" "primary_sg" {
  name        = "vpc-sg"
  description = "Security group for VPC instance"
  vpc_id      = var.vpc_ID

#   dynamic "ingress"{
#   for_each = var.ingress_map 
#   content{
#     description = ingress.value.description
#     from_port   = ingress.value.from_port
#     to_port     = ingress.value.to_port
#     protocol    = ingress.value.protocol
#     cidr_blocks = ingress.value.cidr_blocks
#   }
# }

ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    description = "ICMP from Secondary VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description = "All traffic from Secondary VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "VPC-SG"
    Environment = "Demo"
  }
}
