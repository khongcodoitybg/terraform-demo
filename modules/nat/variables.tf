variable "vpc_id" {
  description = "ID of VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of private subnet need to assign route table"
  type        = string
}

variable "name" {
  description = ""
  type        = string
}
