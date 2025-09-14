resource "helm_release" "argocd" {
  name       = "argo-cd"
  namespace  = var.namespace
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.chart_version

  create_namespace = true
  values           = [file("${path.module}/values.yaml")]
}

resource "helm_release" "argocd_apps" {
  name             = "argo-apps"
  namespace        = var.namespace
  chart            = "${path.module}/charts"
  create_namespace = false

  values = [yamlencode({
    namespace      = var.namespace
    repoURL        = var.repo_url
    targetRevision = var.target_revision
    path           = var.app_path
    destinationNS  = var.destination_ns
  })]

  depends_on = [helm_release.argocd]
}

data "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argo-cd-argocd-server"
    namespace = var.namespace
  }
  depends_on = [helm_release.argocd]
}