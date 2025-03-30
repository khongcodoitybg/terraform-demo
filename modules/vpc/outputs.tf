output "vpc_id" {
  description = "ID of VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "ID of public subnet"
  value       = aws_subnet.public.id
}

output "public_subnet1_id" {
  description = "ID of public subnet"
  value       = aws_subnet.public-1.id
}

output "private_subnet_id" {
  description = "ID of private subnet"
  value       = aws_subnet.private.id
}
