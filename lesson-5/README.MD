# lesson-5 — Terraform AWS (S3+DynamoDB backend, VPC, ECR)

## Структура

lesson-5/
├── backend.tf
├── main.tf
├── outputs.tf
└── modules/
├── s3-backend/
│ ├── s3.tf
│ ├── dynamodb.tf
│ ├── variables.tf
│ └── outputs.tf
├── vpc/
│ ├── vpc.tf
│ ├── routes.tf
│ ├── variables.tf
│ └── outputs.tf
└── ecr/
├── ecr.tf
├── variables.tf
└── outputs.tf

## Команди

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```
