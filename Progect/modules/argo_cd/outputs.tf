output "argocd_server_hostname" {
  value       = try(data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].hostname, "")
  description = "External hostname of Argo CD server (if LoadBalancer)"
}

output "argocd_admin_password_secret" {
  value       = "argocd-initial-admin-secret"
  description = "K8s secret name with Argo CD initial admin password"
}