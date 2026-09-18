# MyApp: Production DevOps Project on AWS EKS

A Python Flask web application deployed to AWS Elastic Kubernetes Service (EKS) with a complete production-grade DevOps pipeline built entirely from scratch.

## What this project demonstrates

This project covers the full DevOps lifecycle from local development to production deployment:

- Containerisation with Docker
- Kubernetes deployment on AWS EKS
- Auto-scaling with Horizontal Pod Autoscaler
- Zero-downtime rolling updates
- Automatic rollback on failed deployments
- Health checks (liveness & readiness probes)
- Multi-environment deployments (staging & production)
- Full CI/CD pipeline with GitHub Actions
- Security scanning with Trivy
- Infrastructure as Code with Terraform
- Monitoring with Prometheus & Grafana
- GitOps with ArgoCD
- RBAC and namespace isolation
- Secrets management with AWS Secrets Manager
- Container security (non-root users, multi-stage builds)

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| Python / Flask | Web application |
| Docker | Containerisation |
| AWS EKS | Kubernetes cluster |
| AWS ECR | Container registry |
| AWS RDS | Managed PostgreSQL database |
| AWS S3 | File storage |
| AWS Lambda | Serverless functions |
| AWS Secrets Manager | Secrets management |
| AWS VPC | Networking & security |
| GitHub Actions | CI/CD pipeline |
| Terraform | Infrastructure as Code |
| Helm | Kubernetes package manager |
| ArgoCD | GitOps continuous delivery |
| Prometheus | Metrics collection |
| Grafana | Monitoring dashboards |
| Trivy | Container vulnerability scanning |
| kubectl | Kubernetes management |
| eksctl | EKS cluster management |

---

## Architecture

**Request flow:**
Internet → Load Balancer (public subnet) → EKS Worker Nodes (private subnet) → App Pods (2 replicas, HPA 2-10) → RDS PostgreSQL, S3, Secrets Manager

**Supporting systems:**
- **Monitoring:** Prometheus + Grafana + AlertManager
- **GitOps:** ArgoCD (auto-syncs with GitHub)
- **CI/CD:** GitHub Actions (5-job pipeline)
- **IaC:** Terraform (57 AWS resources)
- **Security:** Trivy + RBAC + private subnets
<img width="3375" height="3375" alt="Blue Minimalist International Civil Aviation Day Instagram Post " src="https://github.com/user-attachments/assets/cdf830e5-d49b-4f97-a0dc-fcde733a8ca1" />

---

## CI/CD Pipeline

Every push to main automatically:

1. **Tests** - pytest runs 3 tests against the Flask app
2. **Security scan** - detect-secrets checks for committed credentials
3. **Vulnerability scan** - Trivy scans the Docker image for CVEs
4. **Build** - Docker image built and tagged with unique commit SHA
5. **Push** - Image pushed to AWS ECR
6. **Deploy staging** - Rolling update to staging namespace
7. **Approval gate** - Human must approve before production
8. **Deploy production** - Rolling update to production namespace
<img width="1280" height="351" alt="Picture12Screenshot6Git" src="https://github.com/user-attachments/assets/c994bcb5-01fa-4ae8-aeb6-0aeba591fa48" />

---

## Kubernetes Features

- **Namespaces** - development, staging, production environments isolated in one cluster
- **Deployments** - 2 replicas with rolling update strategy
- **Health checks** - liveness probe every 15s, readiness probe every 10s
- **Resource limits** - CPU and memory requests/limits on every pod
- **HPA** - auto-scales from 2 to 10 pods based on CPU usage
- **RBAC** - role-based access control with least privilege
- **Helm** - custom chart for repeatable deployments
- **ArgoCD** - GitOps, cluster syncs automatically with GitHub
<img width="1102" height="253" alt="Screenshot 5 — kubectl pods + nodes" src="https://github.com/user-attachments/assets/29e24922-e402-47d8-8413-2ac117cadc3a" />

---

## Infrastructure as Code (Terraform)

See [terraform-eks](https://github.com/aishacurly/terraform-eks) for the full IaC setup.

Terraform creates 57 AWS resources including:

- VPC with public and private subnets across 3 availability zones
- Internet Gateway and NAT Gateway
- EKS cluster running Kubernetes 1.35
- Managed node groups (t3.small)
- ECR repository
- All IAM roles and security groups

```bash
# Build everything
terraform init
terraform apply

# Connect kubectl
aws eks update-kubeconfig --name myapp-terraform-cluster --region eu-west-2

# Destroy everything
terraform destroy
```
<img width="776" height="720" alt="Screenshot 7 — terraform-eks repo on GitHub" src="https://github.com/user-attachments/assets/b50857ff-b4db-4b6f-9d33-3a0cf1d8c2b6" />

---

## Security

- **Non-root containers** - app runs as appuser not root
- **Multi-stage Docker builds** - minimal attack surface
- **Trivy scanning** - blocks CRITICAL vulnerabilities from reaching production
- **Secrets Manager** - no hardcoded credentials anywhere
- **Private subnets** - pods not directly accessible from internet
- **Security Groups** - least privilege network access
- **IAM roles** - nodes have only the permissions they need

---

## Monitoring

- **Prometheus** - scrapes metrics every 15 seconds
- **Grafana** - real-time dashboards for CPU, memory, network
- **AlertManager** - fires alerts when pods go down
- **Custom alerts** - PodDown alert for default namespace
- **Resource tracking** - CPU and memory limits visible per pod
<img width="1280" height="424" alt="Grafana CPU dashboard" src="https://github.com/user-attachments/assets/c2311ae4-610c-47b2-8716-d04de4e35b94" />
<img width="1270" height="355" alt="Screenshot 2 — Grafana Memory dashboard" src="https://github.com/user-attachments/assets/e51fd567-32e4-4908-ba74-2c1b20bfa82d" />
<img width="1280" height="267" alt="Screenshot 3 — Prometheus query" src="https://github.com/user-attachments/assets/1d3c5a8b-350d-4350-a5fd-0979834becd8" />
<img width="1137" height="482" alt="Screenshot 4 — AlertManager alerts" src="https://github.com/user-attachments/assets/39d5344f-4eeb-4883-b782-7f57f2e7298d" />

---

## How to run locally

```bash
# Clone the repo
git clone https://github.com/aishacurly/myapp.git
cd myapp

# Build Docker image
docker build -t myapp:v1 .

# Run locally
docker run -p 5000:5000 myapp:v1

# Visit
http://localhost:5000
```

---

## How to deploy to EKS

```bash
# Create cluster
eksctl create cluster \
  --name myapp-cluster \
  --region eu-west-2 \
  --nodegroup-name myapp-nodes \
  --node-type t3.small \
  --nodes 2 \
  --managed

# Deploy app
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Get URL
kubectl get service myapp-service

# Clean up (important - stops AWS charges)
kubectl delete service myapp-service
eksctl delete cluster --name myapp-cluster --region eu-west-2
```

---

## Running tests

```bash
pip install flask pytest
pytest test_app.py -v
```

---

## AWS Services used

- **EKS** - Kubernetes cluster
- **ECR** - Docker image registry
- **RDS** - PostgreSQL database
- **S3** - File storage
- **Lambda** - Serverless functions
- **Secrets Manager** - Encrypted secrets storage
- **VPC** - Private networking
- **IAM** - Access control
- **Load Balancer** - Traffic distribution
- **NAT Gateway** - Outbound internet for private subnets

---

## Skills demonstrated

- Linux (Ubuntu/WSL) terminal proficiency
- Docker containerisation and security hardening
- Kubernetes - deployments, services, scaling, RBAC, Helm, ArgoCD
- AWS cloud infrastructure
- CI/CD pipeline design and implementation
- Infrastructure as Code with Terraform
- Production monitoring and alerting
- Container security scanning
- Git and GitHub workflows
- Bash and Python scripting
 
