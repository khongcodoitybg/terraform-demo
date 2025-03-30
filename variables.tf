variable "region" {
  description = "Region AWS"
  type        = string
  default     = "us-west-2"
}

variable "my_ip" {
  type        = string
  description = "your public ip use to ssh into bastion host"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "name of VPC"
  type        = string
  default     = "my-vpc"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet1_cidr" {
  description = "CIDR for public subnet1"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "public_az" {
  description = "Availability Zone for public subnet"
  type        = string
  default     = "us-west-2a"
}

variable "public1_az" {
  description = "Availability Zone for public subnet1"
  type        = string
  default     = "us-west-2c"
}

variable "private_az" {
  description = "Availability Zone for private subnet"
  type        = string
  default     = "us-west-2b"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0f9d441b5d66d5f31" # Amazon Linux 2
}

variable "instance_type" {
  description = "Instance type for fe, be, database"
  type        = string
  default     = "t2.micro"
}

variable "bastion_instance_type" {
  description = "Instance type cho bastion"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name to SSH into instances"
  type        = string
}

variable "lb_name" {
  description = "name of Load Balancer"
  type        = string
  default     = "my-alb"
}

variable "target_port" {
  description = "Port for target group"
  type        = number
  default     = 80
}

variable "listener_port" {
  description = "Port listen for ALB"
  type        = number
  default     = 80
}
