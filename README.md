# Multi-Cloud Portfolio

> Enterprise cloud architecture projects demonstrating AWS, Azure, and GCP implementations with focus on security, compliance, and disaster recovery.

[![Portfolio](https://img.shields.io/badge/Portfolio-Active-green)](https://github.com/higgidv/multi-cloud-portfolio)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-DaSean_Higgins-blue)](https://linkedin.com/in/higginsdasean)

## 🎯 Overview

This repository contains production-grade cloud architecture projects built to demonstrate enterprise cloud engineering skills across multiple cloud providers. Each project focuses on real-world business problems with emphasis on:

- **Security & Compliance** (HIPAA, SOC2, PCI-DSS)
- **Disaster Recovery** (Multi-region, multi-cloud)
- **Infrastructure as Code** (Terraform, CloudFormation)
- **Cost Optimization** (Free tier strategies, FinOps practices)
- **Automation** (CI/CD, compliance scanning, failover orchestration)

---

## 📚 Projects

### 1. Healthcare Multi-Cloud Disaster Recovery 🏥

**Status:** 🟢 Active - Day 4 Complete ✅  
**Path:** [`healthcare-multicloud-dr/`](./healthcare-multicloud-dr/)  
**Live Endpoint:** http://healthcare-fhir-alb-1735242017.us-east-1.elb.amazonaws.com/fhir

HIPAA-compliant disaster recovery architecture with fully operational FHIR R4 API server.

**Completed (Days 1-4):**
- ✅ AWS Primary Infrastructure: 3-tier VPC, 85 resources deployed
- ✅ RDS PostgreSQL: Multi-AZ ready, encrypted, automated backups
- ✅ ECS Fargate: HAPI FHIR server (0.5 vCPU, 1GB memory)
- ✅ Application Load Balancer: Multi-AZ with health checks
- ✅ VPC Endpoints: Private subnet AWS service access (5 endpoints)
- ✅ Remote State: S3 + DynamoDB locking
- ✅ AWS Config: 6 automated HIPAA compliance rules
- ✅ KMS Encryption: Customer-managed keys with rotation
- ✅ Secrets Manager: Zero hardcoded credentials
- ✅ CloudWatch: Centralized logging and monitoring

**In Progress (Days 5-10):**
- 🔄 Azure DR Environment: VNet, Azure SQL, Container Instances
- 🔄 Cross-Cloud Connectivity: VPN or VNet peering
- 🔄 Database Replication: PostgreSQL logical replication
- 🔄 Automated Failover: Python + EventBridge orchestration
- 🔄 Monitoring Dashboards: Unified view across clouds
- 🔄 DR Testing: RTO/RPO validation

**Key Metrics:**
- **Cost:** $0.16/month (99% free tier utilization)
- **Resources:** 85 AWS resources (100% IaC)
- **Architecture:** 3-tier VPC, multi-AZ ready
- **Security:** 6 security groups, KMS encryption, private subnets
- **Compliance:** 6 automated HIPAA rules via AWS Config

**Tech Stack:** Terraform, AWS (ECS, RDS, ALB, VPC), Azure, Python, PostgreSQL, Docker, HAPI FHIR

**Timeline:** 10 days (Oct 28 - Nov 6, 2025) - 40% complete

[View Project →](./healthcare-multicloud-dr/) | [Live FHIR API](http://healthcare-fhir-alb-1735242017.us-east-1.elb.amazonaws.com/fhir/metadata)

**Status:** 🟢 In Progress - Day 5  
**Path:** [`healthcare-multicloud-dr/`](./healthcare-multicloud-dr/)

HIPAA-compliant disaster recovery architecture demonstrating primary/DR pattern across AWS and Azure.

**Key Features:**
- AWS Primary: VPC, RDS PostgreSQL, ECS Fargate (FHIR Server)
- Azure DR: Hot database standby, cold compute containers
- Automated failover orchestration (Python + EventBridge)
- 15-minute RTO, 5-minute RPO
- HIPAA technical safeguards implementation

**Tech Stack:** Terraform, AWS, Azure, Python, PostgreSQL, Docker

**Timeline:** 10 days (Oct 28 - Nov 6, 2025)

[View Project →](./healthcare-multicloud-dr/)

---

### 2. [Future Project: Multi-Cloud Kubernetes Platform] 🚢

**Status:** 🔵 Planned  
**Tentative Start:** November 2025

Enterprise Kubernetes deployment across EKS, AKS, and GKE with unified service mesh.

---

### 3. [Future Project: Serverless Data Pipeline] 📊

**Status:** 🔵 Planned  
**Tentative Start:** December 2025

Event-driven data processing pipeline using AWS Lambda, Azure Functions, and GCP Cloud Functions.

---

### 4. [Future Project: Multi-Cloud Security Posture Management] 🔐

**Status:** 🔵 Planned  
**Tentative Start:** January 2026

Unified security monitoring and compliance scanning across AWS, Azure, and GCP.

---

## 🛠️ Technologies

### Cloud Providers
- **AWS** - Primary expertise, Solutions Architect focus
- **Azure** - Enterprise integration, hybrid cloud
- **GCP** - Data analytics, machine learning workloads

### Infrastructure as Code
- **Terraform** - Multi-cloud provisioning
- **AWS CloudFormation** - AWS-native IaC
- **Azure ARM Templates** - Azure-native IaC

### Programming & Scripting
- **Python 3.11+** - Automation, orchestration, compliance scanning
- **Bash** - Linux system administration, CI/CD scripting
- **PowerShell** - Windows automation, Azure management

### Containers & Orchestration
- **Docker** - Application containerization
- **Kubernetes** - Container orchestration (EKS, AKS, GKE)
- **Helm** - Kubernetes package management

### Databases
- **PostgreSQL** - Primary relational database
- **MySQL/MariaDB** - Alternative RDBMS
- **MongoDB** - Document database
- **Redis** - Caching layer

### CI/CD & DevOps
- **GitHub Actions** - CI/CD pipelines
- **Jenkins** - Enterprise CI/CD
- **ArgoCD** - GitOps for Kubernetes

---

## 📖 Learning Objectives

This portfolio demonstrates:

1. **Multi-Cloud Architecture Design**
   - Cross-cloud networking strategies
   - Vendor lock-in mitigation
   - Cost-benefit analysis of multi-cloud vs multi-region

2. **Enterprise Security & Compliance**
   - HIPAA technical safeguards
   - Zero-trust network architecture
   - Encryption at rest and in transit
   - Audit logging and compliance automation

3. **Disaster Recovery Planning**
   - RTO/RPO analysis and implementation
   - Automated failover orchestration
   - Backup and restore strategies
   - DR testing procedures

4. **Infrastructure as Code Best Practices**
   - Modular Terraform design
   - State management strategies
   - Testing and validation
   - Documentation standards

5. **Cost Optimization**
   - Free tier maximization
   - Reserved instance strategies
   - Right-sizing methodologies
   - FinOps implementation

---

## 🚀 Quick Start

### Prerequisites

- AWS Account (free tier eligible)
- Azure Account (free tier eligible)
- GCP Account (optional, for future projects)
- Terraform 1.6+
- AWS CLI v2
- Azure CLI
- Python 3.11+
- Docker Desktop

### Clone Repository
```bash
git clone https://github.com/higgidv/multi-cloud-portfolio.git
cd multi-cloud-portfolio
```

### Navigate to a Project
```bash
# Healthcare Multi-Cloud DR project
cd healthcare-multicloud-dr
cat README.md  # Read project-specific instructions
```

---

## 📊 Repository Structure
```
multi-cloud-portfolio/
├── README.md                          # This file
├── .gitignore                         # Git ignore rules
│
├── healthcare-multicloud-dr/          # Project 1
│   ├── README.md
│   ├── terraform/
│   │   ├── aws-primary/
│   │   └── azure-dr/
│   ├── scripts/
│   ├── docs/
│   └── diagrams/
│
├── kubernetes-multicloud/             # Project 2 (future)
│   └── README.md
│
├── serverless-data-pipeline/          # Project 3 (future)
│   └── README.md
│
└── security-posture-management/       # Project 4 (future)
    └── README.md
```

---

## 👤 About

**DaSean Higgins**  
Cloud Architect | Multi-Cloud Specialist | 15+ Years Infrastructure Experience

Transitioning from system administration to cloud architecture with focus on:
- **Healthcare:** HIPAA compliance, FHIR interoperability, patient data protection
- **Manufacturing:** Industrial IoT, OT/IT integration, supply chain resilience
- **Cybersecurity:** Zero-trust networks, identity management, compliance automation
- **Disaster Recovery:** Multi-cloud failover, RTO/RPO optimization
- **Cost Engineering:** FinOps practices, budget optimization
- **Infrastructure as Code:** Terraform, automated deployments

### Connect
- 🔗 [LinkedIn](https://linkedin.com/in/higginsdasean)
- 📧 [Email](mailto:higgins.dasean@gmail.com)
- 🌐 [Portfolio Website](https://higgidv.github.io)

---

## 📈 Project Timeline

| Project | Status | Start Date | Current Progress | Target Completion | Duration |
|---------|--------|------------|------------------|-------------------|----------|
| Healthcare Multi-Cloud DR | 🟢 Active | Oct 28, 2025 | **Day 4/10 (40%)** | Nov 6, 2025 | 10 days |
| Kubernetes Multi-Cloud | 🔵 Planned | Nov 10, 2025 | Not started | Nov 24, 2025 | 14 days |
| Serverless Data Pipeline | 🔵 Planned | Dec 1, 2025 | Not started | Dec 15, 2025 | 14 days |
| Security Posture Mgmt | 🔵 Planned | Jan 5, 2026 | Not started | Jan 19, 2026 | 14 days |

**Goal:** Complete 6-12 portfolio projects by June 2026

**Days Completed:** 4 of 10 (Healthcare DR)  
**Resources Deployed:** 85 AWS resources  
**Total Project Cost:** $0.16/month
## 📄 License

MIT License - See individual project directories for specific licenses.

---

## ⭐ Support

If these projects help you learn cloud architecture, please star this repository!

**Current Progress:**
- 📊 **Projects:** 1 of 12 active (8% complete)
- 🏗️ **Resources Deployed:** 85 AWS resources
- 💰 **Total Cost:** $0.16/month
- 📅 **Days Completed:** 4 of 40 planned work days (10%)
- ✅ **Milestones:** AWS primary infrastructure operational

If these projects help you learn cloud architecture, please star this repository!

**Current Progress:** 1 of 12 projects (8% complete)

---

**Last Updated:** November 4, 2025  
**Repository Maintainer:** DaSean Higgins (@higgidv)