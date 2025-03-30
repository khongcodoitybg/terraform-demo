output "bastion_sg_id" {
  description = "ID of Bastion security group"
  value       = aws_security_group.bastion_sg.id
}

output "ec2_sg_id" {
  description = "ID of EC2 security group"
  value       = aws_security_group.ec2_sg.id
}

output "lb_sg_id" {
  description = "ID of LB security group"
  value       = aws_security_group.lb_sg.id
}

output "fe_sg_id" {
  description = "ID of FE security group"
  value       = aws_security_group.fe_sg.id
}
output "database_sg_id" {
  description = "ID of DB security group"
  value       = aws_security_group.db_sg.id
}
output "be_sg_id" {
  description = "ID of BE security group"
  value       = aws_security_group.be_sg.id
}

