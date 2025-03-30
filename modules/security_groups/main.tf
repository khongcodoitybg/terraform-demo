resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "SG allow Bastion host"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow SSH from privacy IP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    description = "allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "SG allow EC2 instance (FE, BE, Database)"
  vpc_id      = var.vpc_id

  ingress {
    description     = "allow SSH from Bastion"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }
  egress {
    description = "allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "lb-sg"
  description = "SG for Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb-sg"
  }
}

# Security Group for Frontend (FE)
resource "aws_security_group" "fe_sg" {
  name        = "fe-sg"
  description = "SG for fe"
  vpc_id      = var.vpc_id

  ingress {
    description     = "allow HTTP from Load Balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }

  ingress {
    description     = "allow HTTP from Load Balancer"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "fe_sg"
  }
}

resource "aws_security_group" "be_sg" {
  name   = "be_sg"
  vpc_id = var.vpc_id

  # Allow API (3000) only from FE SG
  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.fe_sg.id] # Only allow FE
  }

  # Allow SSH from bastion host only
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "be_sg"
  }
}

# Security Group for Database (DB)
resource "aws_security_group" "db_sg" {
  vpc_id = var.vpc_id
  name   = "db_sg"

  # Allow MySQL (3306) only from BE SG
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.be_sg.id] # Only allow BE
  }

  egress {
    description = "allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db_sg"
  }
}
