# Adding Internet Gateway for the VPC
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    "Name" = "${local.name_suffix}-IGW"
  }
}
