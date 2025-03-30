resource "aws_instance" "fe" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = var.instance_sg_ids
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = "fe"
  }
}

resource "aws_instance" "be" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = var.instance_sg_ids
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = "be"
  }
}

resource "aws_instance" "database" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = var.instance_sg_ids
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = "database"
  }
}

resource "aws_instance" "bastion" {
  ami                    = var.ami_id
  instance_type          = var.bastion_instance_type
  subnet_id              = var.public_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = var.bastion_sg_ids
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = "bastion"
  }
}

data "template_file" "user_data" {
  template = <<-EOT
    #!/bin/bash
    set -e
    sed -i 's/^#Port 22/Port 8080/' /etc/ssh/sshd_config
    sed -i 's/^Port 22/Port 8080/' /etc/ssh/sshd_config
    systemctl restart sshd
  EOT
}
