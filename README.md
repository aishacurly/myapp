# MyApp — Production DevOps Project on AWS EKS

A Python Flask web application deployed to AWS Elastic Kubernetes Service (EKS) with a complete production-grade DevOps pipeline built entirely from scratch.

---

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
---

## CI/CD Pipeline

Every push to main automatically:

1. **Tests** — pytest runs 3 tests against the Flask app
2. **Security scan** — detect-secrets checks for committed credentials
3. **Vulnerability scan** — Trivy scans the Docker image for CVEs
4. **Build** — Docker image built and tagged with unique commit SHA
5. **Push** — Image pushed to AWS ECR
6. **Deploy staging** — Rolling update to staging namespace
7. **Approval gate** — Human must approve before production
8. **Deploy production** — Rolling update to production namespace

---

## Kubernetes Features

- **Namespaces** — development, staging, production environments isolated in one cluster
- **Deployments** — 2 replicas with rolling update strategy
- **Health checks** — liveness probe every 15s, readiness probe every 10s
- **Resource limits** — CPU and memory requests/limits on every pod
- **HPA** — auto-scales from 2 to 10 pods based on CPU usage
- **RBAC** — role-based access control with least privilege
- **Helm** — custom chart for repeatable deployments
- **ArgoCD** — GitOps, cluster syncs automatically with GitHub

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

---

## Security

- **Non-root containers** — app runs as appuser not root
- **Multi-stage Docker builds** — minimal attack surface
- **Trivy scanning** — blocks CRITICAL vulnerabilities from reaching production
- **Secrets Manager** — no hardcoded credentials anywhere
- **Private subnets** — pods not directly accessible from internet
- **Security Groups** — least privilege network access
- **IAM roles** — nodes have only the permissions they need

---

## Monitoring

- **Prometheus** — scrapes metrics every 15 seconds
- **Grafana** — real-time dashboards for CPU, memory, network
- **AlertManager** — fires alerts when pods go down
- **Custom alerts** — PodDown alert for default namespace
- **Resource tracking** — CPU and memory limits visible per pod

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

- **EKS** — Kubernetes cluster
- **ECR** — Docker image registry
- **RDS** — PostgreSQL database
- **S3** — File storage
- **Lambda** — Serverless functions
- **Secrets Manager** — Encrypted secrets storage
- **VPC** — Private networking
- **IAM** — Access control
- **Load Balancer** — Traffic distribution
- **NAT Gateway** — Outbound internet for private subnets

---

## Skills demonstrated

- Linux (Ubuntu/WSL) terminal proficiency
- Docker containerisation and security hardening
- Kubernetes — deployments, services, scaling, RBAC, Helm, ArgoCD
- AWS cloud infrastructure
- CI/CD pipeline design and implementation
- Infrastructure as Code with Terraform
- Production monitoring and alerting
- Container security scanning
- Git and GitHub workflows
- Bash and Python scripting
