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

**Status:** 🟢 Active - Day 6 Complete - Azure Security Hardening ✅  
**Path:** [`healthcare-multicloud-dr/`](./healthcare-multicloud-dr/)  
**Live Endpoint:** http://healthcare-fhir-alb-1735242017.us-east-1.elb.amazonaws.com/fhir

HIPAA-compliant disaster recovery architecture with fully operational FHIR R4 API server spanning AWS and Azure.

**AWS Primary (Complete - Days 1-4):**
- ✅ 3-Tier VPC Architecture: 85 resources deployed
- ✅ RDS PostgreSQL: Multi-AZ ready, encrypted, automated backups
- ✅ ECS Fargate: HAPI FHIR server (0.5 vCPU, 1GB memory)
- ✅ Application Load Balancer: Multi-AZ with health checks
- ✅ VPC Endpoints: Private subnet AWS service access (5 endpoints)
- ✅ Remote State: S3 + DynamoDB locking
- ✅ AWS Config: 6 automated HIPAA compliance rules
- ✅ KMS Encryption: Customer-managed keys with rotation
- ✅ Secrets Manager: Zero hardcoded credentials
- ✅ CloudWatch: Centralized logging and monitoring

**Azure DR (Security Hardening Complete - Days 5-6):**
- ✅ Resource Group: healthcare-dr-rg (East US 2)
- ✅ Virtual Network: 3-tier architecture (10.1.0.0/16)
- ✅ Network Security Groups: Least-privilege access controls
- ✅ Azure SQL Database: Basic tier (free tier, 2GB)
- ✅ Private Endpoint: Secure SQL connectivity (10.1.3.4)
- ✅ Private DNS Zone: privatelink.database.windows.net
- ✅ Extended Auditing: Server + database level (7-day retention)
- ✅ Storage Account: Audit logs with 7-day soft delete
- ✅ Microsoft Defender for SQL: Advanced Threat Protection
- ✅ Diagnostic Settings: Metrics to Log Analytics
- ✅ Log Analytics: 30-day retention workspace
- ✅ Action Group: Security alert notifications
- ✅ 26-28 Azure resources deployed at $0.00 cost

**In Progress (Days 7-10):**
- 🔄 Cross-Cloud VPN Gateway connectivity
- 🔄 Database replication: PostgreSQL → Azure SQL
- 🔄 Automated Failover: Python + EventBridge orchestration
- 🔄 Unified monitoring dashboards
- 🔄 DR Testing: RTO/RPO validation (target: 15min/5min)

**Key Metrics:**
- **Cost:** $4.36/month current (prorated) | Est. $30-50/month full month
- **AWS Resources:** 85 resources (100% IaC)
- **Azure Resources:** 26-28 resources (100% IaC)
- **Total Infrastructure:** 111-113 resources across 2 clouds
- **Architecture:** Multi-cloud, 3-tier, multi-AZ ready
- **Security:** Defense-in-depth, Private Endpoints, encryption at rest/transit
- **Compliance:** HIPAA §164.312 technical safeguards automated

**Tech Stack:** Terraform, AWS (ECS, RDS, ALB, VPC), Azure (VNet, SQL, Private Endpoint, Defender for SQL), Python, PostgreSQL, Docker, HAPI FHIR

**Timeline:** 10 days (Oct 28 - Nov 6, 2025) - 60% complete

[View Project →](./healthcare-multicloud-dr/) | [Live FHIR API](http://healthcare-fhir-alb-1735242017.us-east-1.elb.amazonaws.com/fhir/metadata)

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
- **Terraform** - Multi-cloud provisioning (1,500+ lines HCL)
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
- **Azure SQL** - Azure-native relational database
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
   - Cross-cloud networking strategies (Private Endpoints, VPN Gateway)
   - Vendor lock-in mitigation
   - Cost-benefit analysis of multi-cloud vs multi-region

2. **Enterprise Security & Compliance**
   - HIPAA technical safeguards (§164.312 compliance)
   - Zero-trust network architecture (Private Endpoints)
   - Encryption at rest and in transit (KMS, TLS 1.2)
   - Audit logging and compliance automation (Extended Auditing, AWS Config)

3. **Disaster Recovery Planning**
   - RTO/RPO analysis and implementation (target: 15min/5min)
   - Automated failover orchestration
   - Backup and restore strategies
   - DR testing procedures

4. **Infrastructure as Code Best Practices**
   - Modular Terraform design (1,500+ lines HCL)
   - State management strategies (remote state, locking)
   - Testing and validation
   - Documentation standards

5. **Cost Optimization**
   - Free tier maximization (99.84% cost efficiency)
   - Reserved instance strategies
   - Right-sizing methodologies
   - FinOps implementation

---

## 🚀 Quick Start

### Prerequisites

- AWS Account (free tier eligible)
- Azure Account (free tier eligible)
- GCP Account (optional, for future projects)
- Terraform 1.12+
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
├── healthcare-multicloud-dr/          # Project 1: HIPAA Multi-Cloud DR
│   ├── README.md
│   ├── terraform/
│   │   ├── aws-primary/               # AWS infrastructure (85 resources)
│   │   └── azure-dr/                  # Azure DR (26-28 resources)
│   ├── scripts/
│   │   ├── compliance/
│   │   ├── dr-failover/
│   │   └── backup/
│   ├── docs/
│   │   ├── DEPLOYMENT_LOG.md          # Daily progress log
│   │   ├── DAY5_AZURE_DEPLOYMENT.md   # Azure foundation details
│   │   ├── DAY6_AZURE_SECURITY.md     # Azure security hardening details
│   │   ├── architecture.md
│   │   ├── compliance-matrix.md
│   │   └── cost-analysis.md
│   └── diagrams/
│       └── screenshots/
│           ├── aws/
│           └── azure/
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
Cloud Architect | Multi-Cloud Specialist | 10+ Years Infrastructure Experience

Transitioning from system administration to cloud architecture with focus on:
- **Healthcare IT:** HIPAA compliance, FHIR interoperability, patient data protection
- **Multi-Cloud Strategy:** AWS + Azure disaster recovery, vendor diversification
- **Security & Compliance:** Zero-trust networks, Private Endpoints, automated compliance monitoring
- **Disaster Recovery:** Cross-cloud failover, RTO/RPO optimization
- **Cost Engineering:** FinOps practices, free tier optimization ($0.16/month for 111+ resources)
- **Infrastructure as Code:** Terraform expertise, 100% automated deployments

### Connect
- 🔗 [LinkedIn](https://linkedin.com/in/higginsdasean)
- 📧 [Email](mailto:higgins.dasean@gmail.com)
- 💼 [GitHub](https://github.com/higgidv)

---

## 📈 Project Timeline

| Project | Status | Start Date | Current Progress | Target Completion | Duration |
|---------|--------|------------|------------------|-------------------|----------|
| Healthcare Multi-Cloud DR | 🟢 Active | Oct 28, 2025 | **Day 6/10 (60%)** | Nov 11, 2025 | 10 days |
| Kubernetes Multi-Cloud | 🔵 Planned | Nov 12, 2025 | Not started | Nov 26, 2025 | 14 days |
| Serverless Data Pipeline | 🔵 Planned | Dec 1, 2025 | Not started | Dec 15, 2025 | 14 days |
| Security Posture Mgmt | 🔵 Planned | Jan 5, 2026 | Not started | Jan 19, 2026 | 14 days |

**Goal:** Complete 6-12 portfolio projects by June 2026

---

## 💰 Cost Transparency

Demonstrating production-grade infrastructure with realistic cost analysis:

| Cloud Provider | Resources | Current Cost (Prorated) | Projected Full Month | Free Tier Status |
|----------------|-----------|------------------------|---------------------|------------------|
| AWS | 85 resources | $4.30 | $28-32 | 85% free tier |
| Azure | 26-28 resources | $0.06 | $0-20 | 99% free tier |
| **Total** | **111-113 resources** | **$4.36/month** | **$30-50/month** | **87% free tier** |

**Current Cost Breakdown (Prorated):**
- AWS RDS PostgreSQL (db.t3.micro): $3.50 (prorated from $12/month)
- AWS Application Load Balancer: $0.80 (prorated from $16/month)
- AWS KMS keys (2): $0.00 (included in monthly minimum)
- Azure SQL Database: $0.06 (minimal usage charges)
- All other services: Free tier

**Full Month Cost Projections:**

**AWS Services:**
- RDS PostgreSQL (db.t3.micro): $12.41/month (exceeds 750hr free tier)
- Application Load Balancer: $16.20/month (not free tier eligible)
- KMS Keys (2): $2.00/month ($1/key - required for encryption)
- ECS Fargate: $0.00 (within 400 vCPU-hour free tier)
- VPC Endpoints (5): $0.00 (data processing charges minimal)
- CloudWatch, S3, etc.: $0.00 (within free tier limits)

**Azure Services:**
- SQL Database Basic: $0-5.00/month (250GB free tier, minimal usage charges)
- Microsoft Defender for SQL: $0-15.00/month (currently in evaluation period)
- Virtual Network, Private Endpoint: $0.00 (always free/within limits)
- Log Analytics, Storage: $0.00 (within 5GB free tier)

**Cost Optimization Notes:**
- **Current architecture prioritizes production-readiness over cost minimization**
- Could reduce to ~$5/month by:
  - Using db.t4g.micro (Graviton) instead of db.t3.micro
  - Stopping RDS when not actively testing
  - Using EC2 with NGINX instead of ALB (saves $16/month)
- **Interview value:** Demonstrates understanding of real AWS costs vs. free tier tricks
- **Trade-off:** Production-grade architecture (Multi-AZ ALB, persistent RDS) vs. portfolio cost optimization

**Savings vs Typical Enterprise Architecture:** $500+/month saved through:
- Single-AZ RDS vs. Multi-AZ production setup (~$25/month savings)
- No NAT Gateway (using VPC Endpoints + public subnets): $32/month savings
- Basic tier Azure SQL vs. Standard tier: $200+/month savings
- Minimal compute (ECS Fargate within free tier): $50+/month savings

Demonstrating production-grade infrastructure without breaking the bank:

| Cloud Provider | Resources | Monthly Cost | Free Tier Status |
|----------------|-----------|--------------|------------------|
| AWS | 85 resources | $0.16 | 99% free tier |
| Azure | 26-28 resources | $0.00 | 100% free tier |
| **Total** | **111-113 resources** | **$0.16/month** | **99.84% free** |

**Cost Breakdown:**
- AWS KMS keys (2): $0.16/month (required for HIPAA compliance)
- AWS Secrets Manager (1): Included in KMS cost
- Everything else: Free tier eligible

**Potential Azure Costs to Monitor:**
- Microsoft Defender for SQL: May incur $15/month after evaluation period

**Savings vs Typical Architecture:** $57/month saved through:
- VPC endpoints instead of NAT Gateway ($32/month)
- Single-AZ RDS instead of Multi-AZ ($15/month)
- Public subnets for ECS instead of NAT ($10/month)

---

## 🔐 Security Highlights

**Defense-in-Depth Implementation:**
- ✅ Network isolation: Private Endpoints, VPC Endpoints, security groups, NSGs
- ✅ Data encryption: KMS (AWS), Storage encryption (Azure), TLS 1.2 minimum
- ✅ Audit logging: CloudTrail, Extended Auditing (7-day retention)
- ✅ Threat detection: AWS Config rules, Microsoft Defender for SQL
- ✅ Identity management: IAM roles, Azure AD authentication
- ✅ Compliance automation: HIPAA §164.312 technical safeguards

---

## 📄 License

MIT License - See individual project directories for specific licenses.

---

## ⭐ Support

If these projects help you learn cloud architecture, please star this repository!

**Current Progress:**
- 📊 **Projects:** 1 of 12 active (8% complete)
- 🏗️ **Resources Deployed:** 111-113 resources (85 AWS + 26-28 Azure)
- 🌍 **Cloud Providers:** 2 (AWS + Azure)
- 💰 **Total Cost:** $0.16/month (99.84% free tier efficiency)
- 📅 **Days Completed:** 6 of 10 (Healthcare DR - 60% complete)
- ✅ **Milestones:** AWS primary operational, Azure DR security hardening complete

**Day 6 Achievement:** Implemented enterprise-grade security with Private Endpoints, Extended Auditing, and Microsoft Defender for SQL while maintaining 100% Azure free tier compliance.

---

**Last Updated:** November 5, 2025  
**Repository Maintainer:** DaSean Higgins (@higgidv)