output "nat_gateway_id" {
  description = "ID của NAT Gateway"
  value       = aws_nat_gateway.this.id
}
