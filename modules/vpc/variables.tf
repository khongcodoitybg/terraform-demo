variable "vpc_cidr" {
  description = "CIDR of VPC"
  type        = string
}

variable "vpc_name" {
  description = "Tên for VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR of public subnet"
  type        = string
}

variable "public_subnet1_cidr" {
  description = "CIDR of public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR of private subnet"
  type        = string
}

variable "public_az" {
  description = "Availability Zone for public subnet"
  type        = string
}

variable "public1_az" {
  description = "Availability Zone for public subnet"
  type        = string
}

variable "private_az" {
  description = "Availability Zone for private subnet"
  type        = string
}
