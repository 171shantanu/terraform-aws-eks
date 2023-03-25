# IAM role for EKS
resource "aws_iam_role" "eks_iam_role" {
  name = "${local.name_suffix}-IAM-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    "Name" = "${local.name_suffix}-IAM-Role"
  }
}

# Data block for IAM EKS Cluster Policy Attachment
data "aws_iam_policy" "aws_eks_policy" {
  name = "AmazonEKSClusterPolicy"
}

# Attaching the AmazonEKSCLusterPolicy to the EKS IAM Role
resource "aws_iam_role_policy_attachment" "eks_role_policy_attachement" {
  policy_arn = data.aws_iam_policy.aws_eks_policy.arn
  role       = aws_iam_role.eks_iam_role.name
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "${local.name_suffix}-Cluster-1-TF"
  role_arn = aws_iam_role.eks_iam_role.arn
  version  = var.eks_version

  vpc_config {
    endpoint_public_access  = true
    endpoint_private_access = false

    subnet_ids = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
      aws_subnet.private_1.id,
      aws_subnet.private_2.id,
    ]
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_role_policy_attachement
  ]

  tags = {
    "Name"    = "${local.name_suffix}-Cluster-1-TF"
    "Version" = var.eks_version
  }
}
