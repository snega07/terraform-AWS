# # output "ec2_instance_details" {
# #   value = module.ec2.EC2_Instance_details
# # }

# # output "function_app_name" {
# #   value = module.function.function_app_name
# # }

output "VPC_ID"{
    value = module.vpc.VPC_ID
}

output "Peer_ID"{
    value = module.vpc_east.VPC_ID
}
