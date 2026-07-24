# module "ec2" {
#   source            = "./modules/type"
#   EC2_AMI           = data.aws_ami.ubuntu.id
#   EC2_INSTANCE_TYPE = var.EC2_INSTANCE_TYPE
#   key_name          = var.key_name
#   subnet_id         = data.aws_subnet.selected.id
#   security_group_ids = [data.aws_security_group.selected.id]
#   tags = var.tags

# }

# module "function" {
#   source = "./modules/function"
#   app_name = var.app_name
# }

module "CloudFront"{
    source = "./modules/cloudfront_S3"
    bucket_name = "project-letzgo-cf"
}

# module "vpc_peering"{
#     source = "./modules/vpc"
#     primary_cidr = "10.0.0.0/16"
#     primary_subnet_cidr = "10.0.1.0/24"
# }

# module "vpc_peering_east"{
#     source = "./modules/vpc"
#     providers = {
#       aws = aws.east
#     }
#     primary_cidr = "10.1.0.0/16"
#     primary_subnet_cidr = "10.1.1.0/24"
# }

# module "peering_connection"{
#     source = "./modules/peering"
#     providers = {
#         aws.requester = aws
#         aws.accepter = aws.east
#     }

#     vpc_id = module.vpc_peering.VPC_ID
#     peer_id = module.vpc_peering_east.VPC_ID
# }