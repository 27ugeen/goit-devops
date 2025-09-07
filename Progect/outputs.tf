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