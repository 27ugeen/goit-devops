output "namespace" {
  value = var.namespace
}

output "jenkins_service_name" {
  value = data.kubernetes_service.jenkins.metadata[0].name
}