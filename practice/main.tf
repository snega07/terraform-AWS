module "ec2" {
  source = "./modules/var"
  ami           = var.ami
  instance_type = var.instance_type
  tags          = var.tags
}