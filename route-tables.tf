# Public Route table
resource "aws_route_table" "public_1" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    "Name" = "${local.name_suffix}-Public-Route-Table"
  }
}

# Route for the public route table

resource "aws_route" "public_route_1" {
  route_table_id         = aws_route_table.public_1.id
  destination_cidr_block = var.public_route
  gateway_id             = aws_internet_gateway.eks_igw.id
  depends_on             = [aws_internet_gateway.eks_igw]
}

# Route table for privatve subnet 1

resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    "Name" = "${local.name_suffix}-Private-Route-Table-1"
  }
}

# Route table for privatve subnet 1

resource "aws_route_table" "private_2" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    "Name" = "${local.name_suffix}-Private-Route-Table-2"
  }
}
