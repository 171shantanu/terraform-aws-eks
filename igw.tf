# Adding Internet Gateway for the VPC
resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    "Name" = "EKS-IGW"
  }
}
