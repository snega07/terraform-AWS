module "ec2" {
  source            = "./modules/type"
  EC2_AMI           = var.EC2_AMI
  EC2_INSTANCE_TYPE = var.EC2_INSTANCE_TYPE
  key_name          = var.key_name
}