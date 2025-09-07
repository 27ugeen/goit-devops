terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "tfstate-922718141496-eu-central-1-progect"
    key            = "progect/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks-progect"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}