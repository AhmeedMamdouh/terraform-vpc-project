resource "aws_eip" "nat_eip" {

   domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id
  depends_on    = [aws_eip.nat_eip]

  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_route_table" "private_nat_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-nat-rt"
  }
}
