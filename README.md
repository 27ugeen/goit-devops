# goit-devops

# DevOps Lesson 8–9 – CI/CD Pipeline with Jenkins, Helm, Terraform & Argo CD

## Опис

Цей проєкт реалізує повний CI/CD процес для Django-застосунку з використанням:

- **Terraform** — для автоматизованого створення AWS інфраструктури (VPC, EKS, ECR, Jenkins, Argo CD);
- **Jenkins** — для збірки Docker-образу, пушу в ECR і оновлення Helm chart;
- **Helm + Argo CD** — для автоматичного деплою нової версії застосунку у кластер Kubernetes.

---

## Застосування Terraform

```bash
# Перейти у директорію проєкту
cd Progect

# Форматувати код
terraform fmt -recursive

# Ініціалізувати модулі та плагіни
terraform init -upgrade

# Переглянути план
terraform plan

# Застосувати інфраструктуру
terraform apply
```

Після виконання будуть створені:

- VPC + підмережі
- EKS кластер
- Jenkins (через Helm)
- Argo CD (через Helm)
- ECR репозиторій
- Argo Application для `django-app`

---

## Перевірка Jenkins job

1. Зайти в інтерфейс Jenkins (`kubectl port-forward` або через LoadBalancer URL):

   ```bash
   kubectl -n jenkins get svc jenkins \
     -o jsonpath='{.status.loadBalancer.ingress[0].hostname}{"\\n"}'
   ```

2. Відкрити Dashboard Jenkins у браузері → знайти job **`django-ci`**.
3. Запустити або подивитись останній білд.  
   У логах мають бути:
   - збірка образу Kaniko;
   - пуш образу у ECR;
   - коміт у Git з оновленням `image.tag` у `values.yaml`.

---

## Argo CD

1. Отримати адресу Argo CD:

   ```bash
   kubectl -n argocd get svc argocd-server \
     -o jsonpath='{.status.loadBalancer.ingress[0].hostname}{"\\n"}'
   ```

2. Увійти в веб-інтерфейс Argo CD:

   - користувач: `admin`
   - пароль:
     ```bash
     kubectl -n argocd get secret argocd-initial-admin-secret \
       -o jsonpath="{.data.password}" | base64 -d
     ```

3. На дашборді побачити **Application `django-app`** зі статусом:
   ```
   Synced / Healthy
   ```

---

## Перевірка застосунку в Kubernetes

```bash
# Перевірити деплой, сервіс та HPA
kubectl -n default get deploy,svc,hpa -l argocd.argoproj.io/instance=django-app

# Отримати зовнішній хост застосунку
kubectl -n default get svc django-app-django \
  -o jsonpath='{.status.loadBalancer.ingress[0].hostname}{"\\n"}'

# Перевірити доступність (HTTP 200 OK)
curl -I http://<EXTERNAL-HOSTNAME>
```

---

## Схема CI/CD

```text
GitHub (branch lesson-8-9)
       |
    Jenkins (django-ci pipeline)
       |
  Docker image → Amazon ECR
       |
  Helm chart (values.yaml tag updated in Git)
       |
  Argo CD → EKS (sync application)
       |
  Django app доступний через LoadBalancer
```

# Terraform RDS Module

## Description

Universal module for deploying either a standard AWS RDS instance or an Aurora cluster.  
Works with minimal variable changes and is reusable.

The module always creates:

- DB Subnet Group
- Security Group
- Parameter Group (with defaults: max_connections, log_statement, work_mem)

---

## Usage Example

```hcl
module "rds" {
  source = "./modules/rds"

  name     = "mydb"
  db_name  = "mydb"
  username = "dbuser"
  password = "StrongPassword123!"

  instance_class = "db.t3.micro"
  vpc_id         = module.vpc.vpc_id

  subnet_private_ids = module.vpc.private_subnet_ids
  subnet_public_ids  = module.vpc.public_subnet_ids
  publicly_accessible = false

  # Aurora
  use_aurora                  = true
  engine_cluster              = "aurora-postgresql"
  engine_version_cluster      = "15.3"
  parameter_group_family_aurora = "aurora-postgresql15"
  aurora_replica_count        = 1

  # RDS
  engine                     = "postgres"
  engine_version             = "15.14"
  parameter_group_family_rds = "postgres15"

  # Extras
  backup_retention_period = 7
  allocated_storage       = 20
}
```

---

## Input Variables

- **name** — Base name for the RDS or Aurora resources (string, required)
- **use_aurora** — Switch between Aurora (true) or RDS (false) (bool, required)
- **engine / engine_version** — Engine and version for RDS (string, required)
- **engine_cluster / engine_version_cluster** — Engine and version for Aurora (string, required if Aurora)
- **parameter_group_family_rds** — Example: postgres15 (string, required if RDS)
- **parameter_group_family_aurora** — Example: aurora-postgresql15 (string, required if Aurora)
- **instance_class** — DB instance size (string, required)
- **allocated_storage** — Storage size in GB (RDS only, number, optional)
- **aurora_replica_count** — Number of Aurora replicas (number, optional)
- **db_name** — Database name (string, required)
- **username / password** — Credentials for DB (string, required)
- **vpc_id** — VPC ID (string, required)
- **subnet_private_ids / subnet_public_ids** — Subnets for DB subnet group (list, required)
- **publicly_accessible** — Public access (bool, optional, default false)
- **multi_az** — Multi-AZ for RDS (bool, optional, default false)
- **backup_retention_period** — Retention in days (number, optional)
- **parameters** — Additional DB parameters (map, optional)
- **tags** — Resource tags (map, optional)

---

## How to Change

- Standard RDS ↔ Aurora: toggle `use_aurora`
- Engine or version: update `engine` + `engine_version` (RDS) or `engine_cluster` + `engine_version_cluster` (Aurora)
- Instance class: change `instance_class`
- DB parameters: add entries to `parameters` map

---

## Outputs

- **db_endpoint** — Connection endpoint
- **db_name** — Database name
- **db_engine** — Engine type
- **db_engine_version** — Engine version
