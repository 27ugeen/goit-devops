terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

locals {
  account_id = "922718141496"
  bucket     = "tfstate-922718141496-eu-central-1-progect"
  ddb_table  = "terraform-locks-progect"
}

module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = local.bucket
  table_name  = local.ddb_table
  region      = var.aws_region
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  vpc_name           = "progect-vpc"
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = "progect-eks"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  node_group_name    = "ng-main"
  desired_size       = 2
  min_size           = 2
  max_size           = 4
  instance_types     = ["t3.small"]
  disk_size          = 20
  kubernetes_version = "1.33"
}

module "jenkins" {
  source        = "./modules/jenkins"
  cluster_name  = module.eks.eks_cluster_name
  namespace     = "jenkins"
  chart_version = "5.5.10"
}

module "argo_cd" {
  source = "./modules/argo_cd"

  namespace     = "argocd"
  chart_version = "7.6.12"

  repo_url        = "https://github.com/27ugeen/goit-devops.git"
  target_revision = "lesson-8-9"
  app_path        = "Progect/charts/django-app"
  destination_ns  = "default"
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "lesson-7-django" # або інше ім'я, якщо потрібно
}