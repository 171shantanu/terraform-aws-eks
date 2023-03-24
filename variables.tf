# variable for the project name
variable "project" {
  type        = string
  description = "Project name"
  default     = "EKS"
}

# variable for the environment
variable "env" {
  type        = string
  description = "Environment"
  default     = "Live"
}

# variable for the AWS region.
variable "aws_region" {
  default     = "us-east-1"
  description = "AWS Region"
  type        = string
}

# variable for the CIDR block of the VPC
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.0.0.0/20"
}

# variable for the (0.0.0.0/0) public route
variable "public_route" {
  type        = string
  description = "Public route"
  default     = "0.0.0.0/0"
}
