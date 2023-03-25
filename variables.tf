# variable for the project name
variable "project" {
  type        = string
  description = "Project name"
  default     = "EKS"
}

# variable for the AWS AZ
variable "aws_az" {
  type        = list(string)
  description = "AWS AZ"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
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

# varibale for the CIDR of the public subnets 
variable "public_sub_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR's"
  default     = ["10.0.1.0/28", "10.0.2.0/28"]
}

# varibale for the CIDR of the private subnets 
variable "private_sub_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR's"
  default     = ["10.0.3.0/28", "10.0.4.0/28"]
}

# variable for the EC2 instance type
variable "ec2_instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t2.micro"
}
