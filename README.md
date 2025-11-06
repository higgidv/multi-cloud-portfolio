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

**Status:** 🟢 Active - Day 7 Complete - Cross-Cloud VPN Connectivity ✅  
**Path:** [`healthcare-multicloud-dr/`](./healthcare-multicloud-dr/)  
**Live Endpoint:** http://healthcare-fhir-alb-1735242017.us-east-1.elb.amazonaws.com/fhir

HIPAA-compliant disaster recovery architecture with fully operational FHIR R4 API server spanning AWS and Azure.

**AWS Primary (Complete - Days 1-4):**
- ✅ 3-Tier VPC Architecture: 82 resources deployed
- ✅ RDS PostgreSQL: Multi-AZ ready, encrypted, automated backups
- ✅ ECS Fargate: HAPI FHIR server (0.5 vCPU, 1GB memory)
- ✅ Application Load Balancer: Multi-AZ with health checks
- ✅ VPC Endpoints: Private subnet AWS service access (5 endpoints)
- ✅ Remote State: S3 + DynamoDB locking
- ✅ AWS Config: 6 automated HIPAA compliance rules
- ✅ KMS Encryption: Customer-managed keys with rotation
- ✅ Secrets Manager: Zero hardcoded credentials
- ✅ CloudWatch: Centralized logging and monitoring

**Azure DR (Days 5-6, Destroyed for Cost Management):**
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
- ✅ **Status:** Infrastructure destroyed after Day 7 testing (will rebuild on Day 8)
- ✅ **Terraform Code:** Complete implementation preserved in version control

**Cross-Cloud Connectivity (Day 7 - Validated & Destroyed):**
- ✅ Azure VPN Gateway: VpnGw1 (Public IP: 128.24.23.41)
- ✅ AWS Virtual Private Gateway & Customer Gateway
- ✅ Redundant IPsec Tunnels: Both tunnels verified UP status
  - Tunnel 1: 50.16.41.121 (UP)
  - Tunnel 2: 52.2.3.246 (UP)
- ✅ Static Routes: 10.0.0.0/16 ↔ 10.1.0.0/16 cross-cloud routing
- ✅ AES-256-GCM Encryption: IPsec tunnel security
- ✅ **Cost Management:** Deployed for 6-hour validation ($1.20), then destroyed to save $145/month
- ✅ **Portfolio Evidence:** Screenshots + complete Terraform implementation
- ✅ **Redeployment:** Can rebuild in 45 minutes from Infrastructure as Code

**In Progress (Days 8-10):**
- 🔄 Rebuild Azure DR infrastructure from Terraform
- 🔄 Database replication: PostgreSQL → Azure SQL (AWS DMS)
- 🔄 Automated Failover: Python + EventBridge orchestration
- 🔄 Unified monitoring dashboards
- 🔄 DR Testing: RTO/RPO validation (target: 15min/5min)

**Key Metrics:**
- **Current Cost:** $4.30/month (AWS only, Azure destroyed)
- **Day 7 VPN Cost:** $1.20 (6-hour deployment window)
- **Projected Full Month:** $30-50/month when Azure rebuilt
- **AWS Resources:** 82 resources (100% IaC)
- **Azure Resources:** 5 resources (VNet, DNS - 21 destroyed for cost optimization)
- **Total Active Infrastructure:** 87 resources
- **Architecture:** Multi-cloud, 3-tier, multi-AZ ready, VPN-capable
- **Security:** Defense-in-depth, Private Endpoints, encryption at rest/transit, redundant tunnels
- **Compliance:** HIPAA §164.312 technical safeguards automated
- **Cost Savings:** $145/month saved through temporary VPN deployment strategy

**Tech Stack:** Terraform, AWS (ECS, RDS, ALB, VPC, VPN), Azure (VNet, SQL, Private Endpoint, VPN Gateway, Defender for SQL), Python, PostgreSQL, Docker, HAPI FHIR

**Timeline:** 10 days (Oct 28 - Nov 6, 2025) - 70% complete

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
- **Terraform** - Multi-cloud provisioning (2,500+ lines HCL)
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

### Networking & Security
- **Site-to-Site VPN** - Cross-cloud private connectivity
- **Private Endpoints** - Zero-trust network architecture
- **VPC Peering** - AWS multi-VPC connectivity
- **ExpressRoute/Direct Connect** - Dedicated cloud connectivity

### CI/CD & DevOps
- **GitHub Actions** - CI/CD pipelines
- **Jenkins** - Enterprise CI/CD
- **ArgoCD** - GitOps for Kubernetes

---

## 📖 Learning Objectives

This portfolio demonstrates:

1. **Multi-Cloud Architecture Design**
   - Cross-cloud networking strategies (VPN Gateway, Private Endpoints)
   - Redundant tunnel high availability design
   - Vendor lock-in mitigation
   - Cost-benefit analysis of multi-cloud vs multi-region

2. **Enterprise Security & Compliance**
   - HIPAA technical safeguards (§164.312 compliance)
   - Zero-trust network architecture (Private Endpoints)
   - Encryption at rest and in transit (KMS, TLS 1.2, AES-256-GCM)
   - Audit logging and compliance automation (Extended Auditing, AWS Config)

3. **Disaster Recovery Planning**
   - RTO/RPO analysis and implementation (target: 15min/5min)
   - Automated failover orchestration
   - Cross-cloud database replication
   - Backup and restore strategies
   - DR testing procedures

4. **Infrastructure as Code Best Practices**
   - Modular Terraform design (2,500+ lines HCL)
   - State management strategies (remote state, locking)
   - Resource lifecycle management (deploy → validate → destroy)
   - Testing and validation
   - Documentation standards

5. **Cost Optimization**
   - Strategic free tier utilization (87% efficiency)
   - Temporary deployment strategies (VPN: 6 hours vs 24/7)
   - Infrastructure as Code for rapid redeployment
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
│   │   ├── aws-primary/               # AWS infrastructure (82 resources)
│   │   │   ├── vpn-connectivity.tf    # VPN configuration
│   │   │   └── ...
│   │   └── azure-dr/                  # Azure DR (Terraform code preserved)
│   │       ├── vpn-gateway.tf         # VPN Gateway configuration
│   │       ├── vpn-connection.tf      # VPN connections
│   │       └── ...
│   ├── scripts/
│   │   ├── compliance/
│   │   ├── dr-failover/
│   │   └── backup/
│   ├── docs/
│   │   ├── DEPLOYMENT_LOG.md          # Daily progress log
│   │   ├── MULTI-CLOUD-CONNECTIVITY.md # Day 7 VPN documentation
│   │   ├── DAY5_AZURE_DEPLOYMENT.md   # Azure foundation details
│   │   ├── DAY6_AZURE_SECURITY.md     # Azure security hardening
│   │   ├── architecture.md
│   │   ├── compliance-matrix.md
│   │   └── cost-analysis.md
│   └── diagrams/
│       └── screenshots/
│           ├── aws/
│           │   ├── aws-vpn-tunnels-up-status.png
│           │   └── ...
│           └── azure/
│               ├── azure-vpn-tunnel1-connected.png
│               ├── azure-vpn-tunnel2-connected.png
│               └── ...
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
- **Multi-Cloud Strategy:** AWS + Azure disaster recovery, vendor diversification, cross-cloud networking
- **Security & Compliance:** Zero-trust networks, Private Endpoints, automated compliance monitoring
- **Disaster Recovery:** Cross-cloud failover, RTO/RPO optimization, redundant VPN tunnels
- **Cost Engineering:** FinOps practices, strategic cost/quality trade-offs, temporary deployment strategies
- **Infrastructure as Code:** Terraform expertise, 100% automated deployments, lifecycle management

### Connect
- 🔗 [LinkedIn](https://linkedin.com/in/higginsdasean)
- 📧 [Email](mailto:higgins.dasean@gmail.com)
- 💼 [GitHub](https://github.com/higgidv)

---

## 📈 Project Timeline

| Project | Status | Start Date | Current Progress | Target Completion | Duration |
|---------|--------|------------|------------------|-------------------|----------|
| Healthcare Multi-Cloud DR | 🟢 Active | Oct 28, 2025 | **Day 7/10 (70%)** | Nov 11, 2025 | 10 days |
| Kubernetes Multi-Cloud | 🔵 Planned | Nov 12, 2025 | Not started | Nov 26, 2025 | 14 days |
| Serverless Data Pipeline | 🔵 Planned | Dec 1, 2025 | Not started | Dec 15, 2025 | 14 days |
| Security Posture Mgmt | 🔵 Planned | Jan 5, 2026 | Not started | Jan 19, 2026 | 14 days |

**Goal:** Complete 6-12 portfolio projects by June 2026

---

## 💰 Cost Transparency

Demonstrating production-level infrastructure with realistic cost analysis:

| Cloud Provider | Resources | Current Cost | Notes |
|----------------|-----------|--------------|-------|
| AWS | 82 resources | $4.30/month (prorated) | RDS + ALB running 24/7 |
| Azure | 5 resources | $0.00/month | Infrastructure destroyed, code preserved |
| Day 7 VPN | Destroyed | $1.20 (one-time) | 6-hour deployment window |
| **Total** | **87 active** | **$4.30/month** | **87% free tier** |

**Current Cost Breakdown (Prorated):**
- AWS RDS PostgreSQL (db.t3.micro): $3.50 (prorated from $12/month)
- AWS Application Load Balancer: $0.80 (prorated from $16/month)
- AWS KMS keys (2): Included in monthly minimum
- Azure: $0.00 (all resources destroyed for cost optimization)

**Full Month Cost Projections:**

**AWS Services (Current):**
- RDS PostgreSQL (db.t3.micro): $12.41/month (exceeds 750hr free tier)
- Application Load Balancer: $16.20/month (not free tier eligible)
- KMS Keys (2): $2.00/month ($1/key - required for encryption)
- ECS Fargate: $0.00 (within 400 vCPU-hour free tier)
- VPC Endpoints (5): $0.00 (data processing charges minimal)
- CloudWatch, S3, etc.: $0.00 (within free tier limits)
- **AWS Subtotal:** ~$30/month

**Azure Services (When Rebuilt):**
- SQL Database Basic: $0-5.00/month (250GB free tier, minimal usage charges)
- Microsoft Defender for SQL: $0-15.00/month (currently in evaluation period)
- Virtual Network, Private Endpoint: $0.00 (always free/within limits)
- Log Analytics, Storage: $0.00 (within 5GB free tier)
- **Azure Subtotal:** $0-20/month

**VPN Infrastructure (Temporary Deployment Strategy):**
- Azure VPN Gateway: $0.15/hour = $109/month if persistent
- AWS VPN Connection: $0.05/hour = $36/month if persistent
- **Strategy:** Deploy for testing only (6 hours = $1.20), then destroy
- **Savings:** $145/month by using temporary deployment + IaC redeployment

**Projected Full Month (with Azure rebuilt):** $30-50/month

**Cost Optimization Strategy:**
- **Current architecture prioritizes production-readiness over cost minimization**
- **VPN:** Temporary deployment strategy saves $145/month
- **Azure DR:** Destroyed when not actively testing, rebuild in 30 minutes from Terraform
- Could reduce further to ~$5/month by:
  - Using db.t4g.micro (Graviton) instead of db.t3.micro
  - Stopping RDS when not actively testing
  - Using EC2 with NGINX instead of ALB (saves $16/month)
- **Interview value:** Demonstrates understanding of real AWS costs vs. free tier tricks
- **Trade-off:** Production-grade architecture (Multi-AZ ALB, persistent RDS) vs. portfolio cost optimization

**Total Savings vs Standard Enterprise Architecture:** $400+/month:
- Temporary VPN deployment: $145/month savings
- No NAT Gateway (using VPC Endpoints): $32/month savings
- Single-AZ RDS vs. Multi-AZ: $25/month savings
- Basic tier Azure SQL vs. Standard: $200+/month savings
- Minimal compute (ECS Fargate within free tier): $50+/month savings
- Azure infrastructure lifecycle management: $20/month savings

---

## 🔐 Security Highlights

**Defense-in-Depth Implementation:**
- ✅ Network isolation: Private Endpoints, VPC Endpoints, security groups, NSGs
- ✅ Cross-cloud encryption: IPsec VPN tunnels with AES-256-GCM (when deployed)
- ✅ Data encryption: KMS (AWS), Storage encryption (Azure), TLS 1.2 minimum
- ✅ Audit logging: CloudTrail, Extended Auditing (7-day retention)
- ✅ Threat detection: AWS Config rules, Microsoft Defender for SQL
- ✅ Identity management: IAM roles, Azure AD authentication
- ✅ Compliance automation: HIPAA §164.312 technical safeguards
- ✅ High availability: Redundant VPN tunnels for automatic failover

---

## 📄 License

MIT License - See individual project directories for specific licenses.

---

## ⭐ Support

If these projects help you learn cloud architecture, please star this repository!

**Current Progress:**
- 📊 **Projects:** 1 of 12 active (8% complete)
- 🏗️ **Resources Deployed:** 87 active resources (82 AWS + 5 Azure)
- 🌍 **Cloud Providers:** 2 (AWS + Azure)
- 💰 **Current Cost:** $4.30/month (AWS only, Azure destroyed)
- 💰 **Day 7 VPN:** $1.20 (temporary deployment)
- 📅 **Days Completed:** 7 of 10 (Healthcare DR - 70% complete)
- ✅ **Milestones:** AWS primary operational, Azure DR security implemented, cross-cloud VPN validated
- 🎯 **Architecture:** Production-grade with strategic cost management
- 🔐 **Security:** Multi-layer defense with redundant VPN tunnels
- 💡 **Innovation:** Temporary deployment strategy ($1.20 vs $145/month)

**Day 7 Achievement:** Established and validated redundant IPsec VPN tunnels between AWS and Azure, then strategically destroyed infrastructure to save $145/month while preserving complete implementation as Terraform code for rapid redeployment.

---

**Last Updated:** November 6, 2025  
**Repository Maintainer:** DaSean Higgins (@higgidv)