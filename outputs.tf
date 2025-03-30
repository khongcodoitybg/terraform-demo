output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "fe_instance_id" {
  value = module.ec2.fe_instance_id
}

output "be_instance_id" {
  value = module.ec2.be_instance_id
}

output "database_instance_id" {
  value = module.ec2.database_instance_id
}

output "bastion_instance_id" {
  value = module.ec2.bastion_instance_id
}

output "lb_dns_name" {
  value = module.lb.lb_dns_name
}
