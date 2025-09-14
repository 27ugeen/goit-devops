variable "namespace" {
  type    = string
  default = "argocd"
}

variable "chart_version" {
  type    = string
  default = "7.6.12" # argo-helm chart "argo-cd"
}

variable "repo_url" {
  type    = string
  default = "https://github.com/27ugeen/goit-devops.git"
}

variable "target_revision" {
  type    = string
  default = "lesson-8-9"
}

variable "app_path" {
  type    = string
  default = "Progect/charts/django-app"
}

variable "destination_ns" {
  type    = string
  default = "default"
}