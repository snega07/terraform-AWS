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