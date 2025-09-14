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
