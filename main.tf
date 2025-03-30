provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  public_subnet_cidr  = var.public_subnet_cidr
  public_subnet1_cidr = var.public_subnet1_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_az           = var.public_az
  public1_az          = var.public1_az
  private_az          = var.private_az
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  my_ip  = var.my_ip
}

module "ec2" {
  source                = "./modules/ec2"
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  bastion_instance_type = var.bastion_instance_type
  public_subnet_id      = module.vpc.public_subnet_id
  private_subnet_id     = module.vpc.private_subnet_id
  key_name              = var.key_name
  instance_sg_ids       = [module.security_groups.ec2_sg_id]
  fe_sg_ids             = [module.security_groups.fe_sg_id, module.security_groups.ec2_sg_id]
  be_sg_ids             = [module.security_groups.be_sg_id, module.security_groups.ec2_sg_id]
  db_sg_ids             = [module.security_groups.database_sg_id, module.security_groups.ec2_sg_id]
  bastion_sg_ids        = [module.security_groups.bastion_sg_id, module.security_groups.ec2_sg_id]
}

module "lb" {
  source             = "./modules/lb"
  lb_name            = var.lb_name
  security_group_ids = [module.security_groups.lb_sg_id]
  subnet_ids         = [module.vpc.public_subnet_id, module.vpc.public_subnet1_id]
  target_port        = var.target_port
  listener_port      = var.listener_port
  vpc_id             = module.vpc.vpc_id
  ec2_attachments    = [module.ec2.fe_instance_id]
}

module "nat" {
  source            = "./modules/nat"
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  name              = "quang"
}
