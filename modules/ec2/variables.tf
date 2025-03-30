variable "ami_id" {
  description = "AMI cho EC2 instances"
  type        = string
}
variable "instance_type" {
  description = "instance type for fe, be và database"
  type        = string
}
variable "bastion_instance_type" {
  description = "instance type for bastion"
  type        = string
}
variable "public_subnet_id" {
  description = "ID of public subnet"
  type        = string
}
variable "private_subnet_id" {
  description = "ID of private subnet"
  type        = string
}
variable "key_name" {
  description = "name of key pair để SSH vào instance"
  type        = string
}
variable "instance_sg_ids" {
  description = "list of security group ID apply for fe, be, database"
  type        = list(string)
}
variable "bastion_sg_ids" {
  description = "list of security group ID apply for bastion"
  type        = list(string)
}
variable "fe_sg_ids" {
  description = "list of security group ID apply for fe"
  type        = list(string)
}
variable "be_sg_ids" {
  description = "list of security group ID apply for be"
  type        = list(string)
}
variable "db_sg_ids" {
  description = "list of security group ID apply for database"
  type        = list(string)
}
