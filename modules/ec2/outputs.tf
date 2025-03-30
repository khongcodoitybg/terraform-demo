output "fe_instance_id" {
  description = "ID of instance fe"
  value       = aws_instance.fe.id
}

output "be_instance_id" {
  description = "ID of instance be"
  value       = aws_instance.be.id
}

output "database_instance_id" {
  description = "ID of instance database"
  value       = aws_instance.database.id
}

output "bastion_instance_id" {
  description = "ID of instance bastion"
  value       = aws_instance.bastion.id
}
