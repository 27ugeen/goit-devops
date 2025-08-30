output "bucket_name" {
  description = "Name of the S3 bucket for state files"
  value       = module.s3_backend.bucket_name
}

output "table_name" {
  description = "Name of the DynamoDB table for state locking"
  value       = module.s3_backend.table_name
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID of the created VPC"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "IDs of public subnets"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "IDs of private subnets"
}

output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "ECR repository URL"
}