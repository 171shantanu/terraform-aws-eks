#data block for availabilty zone
data "aws_availability_zones" "az" {
  state = "available"
}

#Adding public subnet 1
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_sub_cidrs[0]
  availability_zone       = data.aws_availability_zones.az.names[0]
  map_public_ip_on_launch = true

  tags = {
    "Name"                      = "${local.name_suffix}-public-us-east-1a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

#Adding public subnet 2
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_sub_cidrs[1]
  availability_zone       = data.aws_availability_zones.az.names[1]
  map_public_ip_on_launch = true

  tags = {
    "Name"                      = "${local.name_suffix}-public-us-east-1b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

#Adding private subnet 1
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.private_sub_cidrs[0]
  availability_zone = data.aws_availability_zones.az.names[0]

  tags = {
    "Name"                            = "${local.name_suffix}-private-us-east-1a"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

#Adding private subnet 2
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.private_sub_cidrs[1]
  availability_zone = data.aws_availability_zones.az.names[1]

  tags = {
    "Name"                            = "${local.name_suffix}-private-us-east-1b"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}
