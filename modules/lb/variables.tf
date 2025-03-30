variable "lb_name" {
  description = "name of Load Balancer"
  type        = string
}

variable "security_group_ids" {
  description = "list of security group ID for Load Balancer"
  type        = list(string)
}

variable "subnet_ids" {
  description = "list of subnet ID for Load Balancer"
  type        = list(string)
}

variable "target_port" {
  description = "Port of target group"
  type        = number
}

variable "listener_port" {
  description = "Port which ALB will listen to"
  type        = number
}

variable "vpc_id" {
  description = "ID of VPC"
  type        = string
}

variable "ec2_attachments" {
  description = "list of instance ID to attach to target group"
  type        = list(string)
}
