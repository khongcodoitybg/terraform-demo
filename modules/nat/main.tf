# Tạo Elastic IP cho NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}

# Tạo NAT Gateway trong public subnet
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "${var.name}-nat"
  }
}

# Tạo Route Table cho private subnet dùng NAT Gateway
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "${var.name}-private-rt"
  }
}

# Gán Route Table cho private subnet
resource "aws_route_table_association" "private" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private.id
}
