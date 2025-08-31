output "cluster_name" {
  value       = aws_eks_cluster.this.name
  description = "EKS cluster name"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.this.endpoint
  description = "EKS cluster API server endpoint"
}

output "cluster_ca" {
  value       = aws_eks_cluster.this.certificate_authority[0].data
  description = "EKS cluster CA certificate"
}

output "node_group_name" {
  value       = aws_eks_node_group.this.node_group_name
  description = "EKS node group name"
}