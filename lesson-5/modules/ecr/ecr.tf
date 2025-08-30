data "aws_caller_identity" "current" {}

resource "aws_ecr_repository" "this" {
  name                 = var.ecr_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name = var.ecr_name
  }
}

# Простий policy: повний доступ для поточного акаунта
resource "aws_ecr_repository_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy     = jsonencode({
    Version = "2008-10-17",
    Statement = [{
      Sid       = "AllowAccount"
      Effect    = "Allow"
      Principal = { "AWS": data.aws_caller_identity.current.account_id }
      Action    = "ecr:*"
    }]
  })
}