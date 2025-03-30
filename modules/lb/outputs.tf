output "lb_dns_name" {
  description = "DNS name of Load Balancer"
  value       = aws_lb.this.dns_name
}
