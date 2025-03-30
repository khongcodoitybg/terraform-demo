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
