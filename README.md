# Lesson 7 — AWS EKS + ECR + Helm (Django)

## Опис

Інфраструктура для Django-застосунку в AWS за допомогою Terraform та Helm.

## Структура проєкту

- `backend.tf` — бекенд Terraform (S3 + DynamoDB).
- `main.tf`, `outputs.tf` — підключення та виводи модулів.
- `modules/`
  - `s3-backend/` — S3-бакет і DynamoDB для state.
  - `vpc/` — VPC з публічними та приватними підмережами, IGW, NAT.
  - `ecr/` — ECR-репозиторій для Docker-образів.
  - `eks/` — EKS кластер і node group.
- `charts/django-app/` — Helm-чарт (Deployment, Service, HPA, ConfigMap).

## Використання

### 1. Terraform

```bash
export AWS_PROFILE=lesson5
terraform init
terraform apply
```

### 2. Збірка та пуш Docker-образу

```bash
aws ecr get-login-password --region eu-central-1 --profile lesson5 \
| docker login --username AWS --password-stdin 922718141496.dkr.ecr.eu-central-1.amazonaws.com

docker buildx build --platform linux/amd64 \
  -t 922718141496.dkr.ecr.eu-central-1.amazonaws.com/lesson-7-django:v3 \
  -f django/Dockerfile ./goit-devops-lesson-4/lesson-4 --push
```

### 3. Деплой у кластер

```bash
aws eks update-kubeconfig --name lesson-7-eks --region eu-central-1 --profile lesson5
helm upgrade --install web charts/django-app
```

### 4. Перевірка

```bash
kubectl get nodes
kubectl get deploy web-django-app
kubectl get svc web-django-app
kubectl get hpa
kubectl get cm web-django-app-config -o yaml
```

### 5. Видалення

⚠️ Щоб уникнути витрат (ELB, NAT Gateway), після перевірки видаліть ресурси:

```bash
helm uninstall web
terraform destroy
```
