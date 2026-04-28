# AWS Cloud-Native E-Commerce: A GitOps Microservices Implementation

![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![ArgoCD](https://img.shields.io/badge/ArgoCD-EF7B4D?style=for-the-badge&logo=argo&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)

This repository demonstrates a production-grade, cloud-native deployment of the **Google Online Boutique** microservices architecture on **Amazon Web Services (AWS)**. It showcases a complete **DevOps Lifecycle**, integrating Infrastructure-as-Code (IaC), Configuration Management, and GitOps-based Continuous Delivery.

## 🏗️ Architecture & AWS Integration

The project utilizes a multi-layered cloud architecture to ensure scalability, security, and automated recovery:

- **Compute (EC2)**: High-performance Amazon EC2 instances (Ubuntu 22.04 LTS) serve as the backbone for the Kubernetes cluster.
- **Networking (VPC & SG)**: Custom AWS Security Groups provisioned via Terraform to manage ingress/egress traffic, securing SSH (22), HTTP (80), and specialized NodePort ranges (30080-30081).
- **Storage (EBS)**: Persistent block storage volumes optimized for Kubernetes state and application data.
- **Infrastructure-as-Code**: **Terraform** manages the entire AWS resource lifecycle, ensuring idempotent and reproducible environments.
- **Configuration Management**: **Ansible** playbooks automate the installation of the container runtime and the GitOps controller.

## 🚀 GitOps & Microservices

The application is deployed using a modern **GitOps** workflow, ensuring that the cluster state always matches the repository configuration:

- **GitOps Controller**: **ArgoCD** monitors this repository and automatically synchronizes the microservices whenever changes are detected.
- **Microservices Ecosystem**: Over 11 independent services interacting via gRPC and REST:
    - **Frontend**: Responsive web interface.
    - **Checkout & Payment**: Secure transaction processing.
    - **Product Catalog & Recommendation**: High-availability data services.
    - **Cart Service**: Backed by **Redis** for sub-millisecond state management.
    - **Shipping & Email**: Automated order fulfillment logic.

## 🛠️ Tech Stack

- **Cloud Provider**: Amazon Web Services (AWS)
- **IaC**: Terraform
- **Automation**: Ansible
- **Orchestration**: Kubernetes (K8s)
- **GitOps**: Argo CD
- **Languages**: Go, Python, Node.js, Java, C#
- **Database/Cache**: Redis

## 📥 Deployment Workflow

1. **Provision Infrastructure**:
   ```bash
   cd terraform-aws
   terraform init && terraform apply
   ```
2. **Configure Node**:
   ```bash
   cd ansible
   ansible-playbook -i inventory.ini argocd-setup.yml
   ```
3. **Access Application**:
   ArgoCD will automatically pull the `online-boutique-fresh.yaml` and deploy it to the cluster. Access the frontend via the EC2 Public IP on the configured NodePort.

---
Developed by [Aman Asif](https://github.com/amanasif01)
