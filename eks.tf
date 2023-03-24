# IAM role for EKS
resource "aws_iam_role" "eks_iam_role" {
  name = "EKS-IAM-Role"
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

    }
  )
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
