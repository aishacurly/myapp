# MyApp — Production DevOps Project

A Python Flask application deployed to AWS EKS with a 
full production-grade DevOps pipeline built from scratch.

## What this project demonstrates

- Containerisation with Docker
- Kubernetes deployment on AWS EKS
- Auto-scaling with Horizontal Pod Autoscaler
- Zero-downtime rolling updates
- Automatic rollback on failed deployments  
- Health checks (liveness & readiness probes)
- Full CI/CD pipeline with GitHub Actions
- Infrastructure as Code with Terraform

## Architecture


## Tech Stack

| Tool | Purpose |
|------|---------|
| Python/Flask | Web application |
| Docker | Containerisation |
| AWS EKS | Kubernetes cluster |
| AWS ECR | Container registry |
| GitHub Actions | CI/CD pipeline |
| Terraform | Infrastructure as Code |
| kubectl | Kubernetes management |

## CI/CD Pipeline

Every push to main automatically:
1. Builds Docker image tagged with commit SHA
2. Pushes to AWS ECR
3. Updates EKS deployment with zero downtime
4. Health checks verify deployment success

## Infrastructure (Terraform)

See [terraform-eks](https://github.com/aishacurly/terraform-eks) 
for the full Infrastructure as Code setup including:
- VPC with public/private subnets
- EKS cluster (Kubernetes 1.35)
- Managed node groups
- ECR repository
- IAM roles and security groups
