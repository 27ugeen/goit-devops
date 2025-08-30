# lesson-5 — Terraform AWS Infrastructure

## Опис проєкту

Цей проєкт створює інфраструктуру в AWS за допомогою Terraform, включаючи:

- збереження стейт-файлів у S3 з блокуванням у DynamoDB,
- VPC з публічними та приватними підмережами,
- репозиторій ECR для Docker-образів.

## Структура проєкту

lesson-5/
├── main.tf # підключення модулів
├── backend.tf # бекенд для стейтів (S3 + DynamoDB)
├── outputs.tf # загальні виходи
└── modules/
├── s3-backend/ # S3 + DynamoDB
│ ├── s3.tf
│ ├── dynamodb.tf
│ ├── variables.tf
│ └── outputs.tf
├── vpc/ # VPC, підмережі, маршрути, IGW, NAT
│ ├── vpc.tf
│ ├── routes.tf
│ ├── variables.tf
│ └── outputs.tf
└── ecr/ # ECR репозиторій
├── ecr.tf
├── variables.tf
└── outputs.tf

## Модулі

- **s3-backend** — створює S3-бакет з версіонуванням і DynamoDB для блокування стейту.
- **vpc** — створює VPC, 3 публічні та 3 приватні підмережі, Internet Gateway, NAT Gateway і таблиці маршрутів.
- **ecr** — створює ECR репозиторій зі скануванням образів.

## Команди

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```
