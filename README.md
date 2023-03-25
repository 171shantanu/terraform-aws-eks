Terraform AWS EKS

The tfstate file for the aws-eks project is stored locally.

The VPC that the EKS cluster is going to be created in, reqiures that the VPC has support for DNS.  
The Subnets for the EKS Cluster must be spread across atleast two different AZ's 
The Subnets that are going to be used for the EKS Cluster must have specails tags allocated to them. 

The Worker Nodes are going to be deployed only in the private subnets.
The Public subnets are going to be used for deploying Load Balancer.