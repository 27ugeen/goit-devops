output "bucket_name" {
  value       = module.s3_backend.bucket_name
  description = "Name of the S3 bucket for state files"
}

output "table_name" {
  value       = module.s3_backend.table_name
  description = "Name of the DynamoDB table for state locking"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "Public subnet IDs"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "Private subnet IDs"
}

output "eks_cluster_name" {
  value       = module.eks.cluster_name
  description = "EKS cluster name"
}

output "eks_cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "EKS API endpoint"
}

output "eks_node_group_name" {
  value       = module.eks.node_group_name
  description = "Managed node group name"
}

output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "ECR repository URL"
}