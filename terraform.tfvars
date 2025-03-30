vpc_cidr              = "10.0.0.0/26"
vpc_name              = "quang-vpc"
public_subnet_cidr    = "10.0.0.0/28"
private_subnet_cidr   = "10.0.0.16/28"
public_subnet1_cidr   = "10.0.0.32/28"
public_az             = "us-west-2a"
private_az            = "us-west-2b"
public1_az            = "us-west-2c"
ami_id                = "ami-0f9d441b5d66d5f31"
instance_type         = "t2.micro"
bastion_instance_type = "t2.micro"
key_name              = "quang-key"
my_ip                 = "*/32"
lb_name               = "quang-lb"
