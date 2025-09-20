output "bucket_name" {
  value = module.s3_backend.bucket_name
}

output "table_name" {
  value = module.s3_backend.table_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}
output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}
output "eks_node_group_name" {
  value = module.eks.eks_node_group_name
}

output "db_endpoint" {
  description = "Database endpoint (RDS or Aurora)"
  value       = module.rds.db_endpoint
}

output "db_name" {
  description = "Database name"
  value       = module.rds.db_name
}

output "db_username" {
  description = "Database master username"
  value       = module.rds.db_username
}

output "db_password" {
  description = "Database master password"
  value       = module.rds.db_password
  sensitive   = true
}