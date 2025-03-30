variable "vpc_id" {
  description = "ID of VPC"
  type        = string
}

variable "my_ip" {
  description = "IP of you to SSH into bastion (eg: 203.0.113.0/32)"
  type        = string
}
