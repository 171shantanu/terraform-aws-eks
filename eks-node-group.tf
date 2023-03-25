# IAM role for the EKS Cluster Node Group (EC2)
resource "aws_iam_role" "eks_node_group_role" {
  name = "${local.name_suffix}-Node-Group-IAM-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    "Name" = "${local.name_suffix}-Node-Group-IAM-Role"
  }
}

# data block to attach the EKS worker node policy to the node group IAM role
data "aws_iam_policy" "eks_worker_node_policy" {
  name = "AmazonEKSWorkerNodePolicy"
}

# data block to attach the EKS worker node policy to the node group IAM role
data "aws_iam_policy" "eks_cni_policy" {
  name = "AmazonEKS_CNI_Policy"
}

# data block to attach the EKS worker node policy to the node group IAM role
data "aws_iam_policy" "ecr_read_only_policy" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

# Resource block to attach the 3 policies to node group IAm role.
resource "aws_iam_role_policy_attachment" "eks_node_group_role_policy_attachement" {
  for_each = toset([
    data.aws_iam_policy.eks_worker_node_policy.arn,
    data.aws_iam_policy.eks_cni_policy.arn,
    data.aws_iam_policy.ecr_read_only_policy.arn
  ])
  policy_arn = each.value
  role       = aws_iam_role.eks_node_group_role.name
}

# Resource block for the EKS Nade Group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${local.name_suffix}-Node-Group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  #Specifying the type of instance to be used using a variable
  instance_types = var.ec2_instance_type

  # The type of AMI that you want to associate with the EKS Node Group
  # The valid values are AL2_x86_64, Al2_x86_64_GPU, AL2_ARM_64
  ami_type = "AL2_x86_64"

  # Defining the capacity type of the EC2 Instance, Valid Vaules are ON_DEMAND, SPOT
  capacity_type = "ON_DEMAND"

  # Specifying the size for the EBS Volumes 
  disk_size = 20

  # Forces version update if existing pods are unable to be drained due to a pod disruption budget issue.
  force_update_version = false

  # K8s version
  version = "1.24"

  # Key-value map of Kubernetes labels
  labels = {
    "role" = "${local.name_suffix}-Node-Group-IAM-Role"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_role_policy_attachement
  ]

  tags = {
    "Name" = "${local.name_suffix}-Node-Group"
  }

}
