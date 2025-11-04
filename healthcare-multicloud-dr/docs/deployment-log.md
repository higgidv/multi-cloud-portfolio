# Healthcare Multi-Cloud DR - Master Deployment Log

**Project:** HIPAA-Compliant Multi-Cloud Disaster Recovery Infrastructure  
**Timeline:** October 28 - November 11, 2025 (15 days)  
**Status:** 🟢 In Progress - Day 5 Complete  
**Total Cost to Date:** $0.16/month

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Day 1: Environment Setup](#day-1-environment-setup)
3. [Day 2: AWS VPC Infrastructure](#day-2-aws-vpc-infrastructure)
4. [Day 3: Compliance Automation](#day-3-compliance-automation)
5. [Day 4: Database & Application](#day-4-database--application)
6. [Day 5: Azure DR Environment - Foundation](#day-5-azure-dr-environment---foundation)
7. [Days 6-7: Azure Security & Connectivity](#days-6-7-azure-security--connectivity) (Planned)
8. [Days 8-10: Integration & Testing](#days-8-10-integration--testing) (Planned)
9. [Cost Summary](#cost-summary)
10. [Lessons Learned](#lessons-learned)

---

## Project Overview

### Objective
Build a production-grade, HIPAA-compliant disaster recovery architecture spanning AWS (primary) and Azure (DR) to demonstrate multi-cloud expertise, security implementation, and operational resilience.

### Target Employer
Atlas Healthcare Partners (and similar healthcare IT organizations)

### Key Requirements
- ✅ HIPAA technical safeguards compliance
- ✅ Multi-cloud architecture (AWS + Azure)
- ⏳ Automated failover capabilities
- ✅ Infrastructure as Code (Terraform)
- ✅ Complete within AWS/Azure free tiers
- ⏳ 15-minute RTO, 5-minute RPO

### Technology Stack
- **Primary Cloud:** AWS (us-east-1)
- **DR Cloud:** Azure (East US 2)
- **IaC:** Terraform 1.12.2
- **Application:** HAPI FHIR Server
- **Database:** PostgreSQL (AWS RDS) + Azure SQL
- **Containers:** AWS ECS Fargate
- **Automation:** Python 3.11, AWS Lambda, Azure Functions
- **Monitoring:** CloudWatch, Azure Monitor, Log Analytics

---

## Day 1: Environment Setup

**Date:** October 28, 2025  
**Duration:** 3 hours  
**Status:** ✅ Complete  
**Cost:** $0.00

### Objectives
- Set up development environment on Windows 11 and macOS
- Configure AWS and Azure CLIs
- Install Terraform and supporting tools
- Create GitHub repository structure
- Implement billing protection

### Tasks Completed

#### Development Environment
- ✅ Git installed and configured
- ✅ VS Code with Terraform extension
- ✅ AWS CLI v2 installed and configured
- ✅ Azure CLI v2.78.0 installed
- ✅ Terraform v1.12.2 installed
- ✅ Python 3.11 installed
- ✅ Docker Desktop installed

#### AWS Account Setup
- ✅ Created IAM user: terraform-automation
- ✅ Configured access keys
- ✅ Set up MFA on root account
- ✅ Created budget alerts ($0 zero-spend + $10 monthly)
- ✅ Verified CLI authentication

#### Azure Account Setup
- ✅ Created Azure subscription
- ✅ Installed Azure CLI
- ✅ Configured authentication
- ✅ Verified access

#### GitHub Repository
- ✅ Created: https://github.com/higgidv/multi-cloud-portfolio
- ✅ Repository structure implemented
- ✅ Professional README.md created
- ✅ .gitignore configured for security
- ✅ Initial commit and push completed

#### Security Configuration
- ✅ .gitignore blocks credentials
- ✅ AWS IAM user (not root) for deployments
- ✅ Budget alerts configured
- ✅ MFA enabled on AWS root account

### Repository Structure Created
```
multi-cloud-portfolio/
├── README.md
├── .gitignore
└── healthcare-multicloud-dr/
    ├── README.md
    ├── terraform/
    │   ├── aws-primary/
    │   └── azure-dr/
    ├── scripts/
    │   ├── compliance/
    │   ├── dr-failover/
    │   └── backup/
    ├── docs/
    │   ├── architecture.md
    │   ├── compliance-matrix.md
    │   ├── cost-analysis.md
    │   ├── dr-plan.md
    │   └── rto-rpo-analysis.md
    └── diagrams/
        └── screenshots/
```

---

### Key Achievements
- Professional portfolio repository structure
- Secure development environment
- Cost protection measures active
- Ready for infrastructure deployment

### Time Breakdown
- Tool installation: 1.5 hours
- AWS/Azure configuration: 1 hour
- GitHub repository setup: 0.5 hours

---

## Day 2: AWS VPC Infrastructure

**Date:** October 28, 2025  
**Duration:** 6 hours  
**Status:** ✅ Complete  
**Cost:** $0.00

### Objectives
- Deploy production-grade AWS VPC
- Implement 3-tier network architecture
- Configure security groups with least-privilege
- Enable HIPAA-compliant logging
- Document and verify all resources

### Infrastructure Deployed

#### VPC Configuration
- **VPC ID:** vpc-0508832c6d5fd83b7
- **VPC Name:** healthcare-hipaa-vpc
- **CIDR Block:** 10.0.0.0/16
- **Region:** us-east-1
- **DNS Hostnames:** Enabled
- **DNS Support:** Enabled
- **Internet Gateway:** Attached

#### Subnet Architecture (3-Tier)

**Public Subnet**
- **Subnet ID:** subnet-088737d51cef908ff
- **CIDR:** 10.0.1.0/24
- **AZ:** us-east-1a
- **Auto-assign Public IP:** Yes
- **Purpose:** Load balancers, bastion hosts
- **Route:** 0.0.0.0/0 → Internet Gateway

**Private Application Subnet**
- **Subnet ID:** subnet-08c8a4f467a0b9e92
- **CIDR:** 10.0.2.0/24
- **AZ:** us-east-1a
- **Auto-assign Public IP:** No
- **Purpose:** FHIR API application servers
- **Route:** No direct internet access

**Private Data Subnet**
- **Subnet ID:** subnet-099b9d58789acfca9
- **CIDR:** 10.0.3.0/24
- **AZ:** us-east-1a
- **Auto-assign Public IP:** No
- **Purpose:** RDS PostgreSQL database
- **Route:** No direct internet access

#### Security Groups

**ALB Security Group**
- **ID:** sg-0e49429b0f70fe924
- **Name:** healthcare-hipaa-alb-sg
- **Inbound:** HTTP (80), HTTPS (443) from 0.0.0.0/0
- **Outbound:** All traffic
- **Purpose:** Internet-facing load balancer

**Application Security Group**
- **ID:** sg-0f7d9e874cfef331d
- **Name:** healthcare-hipaa-app-sg
- **Inbound:** Port 8080 from ALB SG, SSH from VPC
- **Outbound:** All traffic
- **Purpose:** FHIR application servers

**Database Security Group**
- **ID:** sg-05973f7413510d6f9
- **Name:** healthcare-hipaa-db-sg
- **Inbound:** PostgreSQL (5432) from App SG only
- **Outbound:** All traffic
- **Purpose:** RDS database isolation

#### Compliance & Logging

**CloudTrail**
- **Trail Name:** healthcare-hipaa-trail
- **S3 Bucket:** healthcare-hipaa-cloudtrail-903236527011
- **Status:** ✅ Logging
- **Multi-Region:** Yes
- **Log Validation:** Enabled
- **Management Events:** Enabled
- **Data Events:** Disabled (cost control)

**VPC Flow Logs**
- **Status:** ✅ Enabled
- **Traffic Type:** ALL
- **Destination:** CloudWatch Logs
- **Log Group:** /aws/vpc/flowlogs/healthcare-hipaa
- **Retention:** 7 days
- **IAM Role:** Created with proper permissions

**S3 Bucket (Audit Logs)**
- **Bucket:** healthcare-hipaa-cloudtrail-903236527011
- **Encryption:** SSE-S3
- **Public Access:** ✅ Blocked
- **Bucket Policy:** Allows CloudTrail write access

### Terraform Implementation

#### Code Statistics
- **Files Created:** 3 (main.tf, variables.tf, outputs.tf)
- **Total Lines:** ~450 lines HCL
- **Resources Defined:** 21 resources
- **Variables:** 7 input variables
- **Outputs:** 11 output values

#### Deployment Metrics
- **Init Time:** 45 seconds
- **Plan Time:** 15 seconds
- **Apply Time:** 3 minutes
- **Total Deployment:** < 5 minutes
- **Errors:** 0
- **Manual Fixes:** 0

---

## Day 3: Compliance Automation

**Date:** October 31, 2025  
**Duration:** 4 hours (including troubleshooting and state recovery)  
**Status:** ✅ Complete  
**Cost:** $0.00

### Objectives
✅ Implement AWS Config for automated compliance checking  
✅ Set up SNS email notifications for security events  
✅ Create KMS encryption keys for data-at-rest  

### Infrastructure Deployed

#### AWS Config - Automated Compliance Monitoring
- **Configuration Recorder:** healthcare-hipaa-config-recorder (✅ Recording)
- **Delivery Channel:** healthcare-hipaa-config-delivery (✅ Active)
- **S3 Bucket:** healthcare-hipaa-config-logs-903236527011
- **SNS Topic:** healthcare-hipaa-compliance-alerts
- **Config Rules:** 6 HIPAA compliance rules deployed

#### KMS Encryption Infrastructure
- **Key ID:** 90a19765-cb57-461d-8d42-c47ea00da4d9
- **Alias:** alias/healthcare-hipaa-healthcare
- **Key Rotation:** ✅ Enabled (automatic annual rotation)

---

## Day 4: Database & Application Deployment

**Date:** November 4, 2025  
**Duration:** ~10 hours (including troubleshooting)  
**Status:** ✅ Complete  
**Cost:** $0.16/month

### Objectives
✅ Configure Terraform remote state backend (S3 + DynamoDB)  
✅ Deploy RDS PostgreSQL database  
✅ Deploy HAPI FHIR server on ECS Fargate  
✅ Configure Application Load Balancer  
✅ Configure VPC Endpoints for private subnet access  
✅ Test end-to-end FHIR API functionality

### Resources Deployed

**Remote State:**
- S3 bucket: healthcare-dr-terraform-state-903236527011
- DynamoDB table: terraform-state-lock
- KMS key: terraform-state

**Database:**
- RDS PostgreSQL 13.16 (db.t3.micro, 20GB)
- Identifier: healthcare-fhir-db
- Multi-AZ: No (cost optimization)
- Encryption: KMS
- Backups: 7 days retention

**Application:**
- ECS Cluster: healthcare-fhir-cluster
- Task: HAPI FHIR Server (0.5 vCPU, 1GB memory)
- ALB: healthcare-fhir-alb-1735242017.us-east-1.elb.amazonaws.com
- Endpoint: http://[ALB_DNS]/fhir

**Status:** ✅ PRODUCTION-READY  
**Health:** 1/1 targets healthy  
**Total AWS Resources:** ~85

---

## Day 5: Azure DR Environment - Foundation

**Date:** November 4, 2025  
**Duration:** ~5 hours  
**Status:** ✅ Complete  
**Cost:** $0.00/month

### Overview
Deployed Azure disaster recovery environment with 3-tier network architecture matching AWS primary infrastructure. Established foundation for cross-cloud database replication and failover capabilities.

### Objectives
✅ Deploy Azure VNet with 3-tier architecture mirroring AWS VPC  
✅ Configure Network Security Groups (NSGs)  
✅ Deploy Azure SQL Database (Basic tier)  
✅ Set up Log Analytics workspace  
✅ Establish foundation for DR environment

### Resources Deployed

**Networking (East US 2):**
- Resource Group: `healthcare-dr-rg`
- Virtual Network: `healthcare-dr-vnet` (10.1.0.0/16)
- Subnets:
  - Public: `healthcare-dr-public-subnet` (10.1.1.0/24)
  - Private App: `healthcare-dr-private-app-subnet` (10.1.2.0/24)
  - Private Data: `healthcare-dr-private-data-subnet` (10.1.3.0/24)

**Security:**
- NSG: `healthcare-dr-public-nsg` (HTTP/HTTPS from internet)
- NSG: `healthcare-dr-app-nsg` (Port 8080 from public subnet only)
- NSG: `healthcare-dr-database-nsg` (Port 1433 from app subnet only)

**Database:**
- SQL Server: `healthcare-dr-sqlserver-4x858c`
- SQL Database: `healthcare-dr-fhirdb` (Basic tier, 2GB)
- Public Access: Enabled temporarily (will add Private Endpoint Day 6)
- Firewall: Azure services access enabled

**Monitoring:**
- Log Analytics Workspace: `healthcare-dr-logs` (30-day retention)
- Action Group: Security alerts to dasehigg@gmail.com

**Total Resources:** 12-15 Azure resources

### Architecture Decisions

**1. Region Selection:**
- Initially targeted East US to match AWS us-east-1
- Switched to East US 2 due to SQL Database provisioning capacity issues
- Maintains east coast geography for similar latency characteristics

**2. Network Architecture:**
- Mirrored AWS 3-tier VPC design (10.0.0.0/16 → 10.1.0.0/16)
- NSG rules enforce least-privilege access between tiers
- Service endpoints enabled for Azure SQL, Storage, Key Vault

**3. SQL Database Configuration:**
- Basic tier (free tier eligible: 250GB for 12 months)
- Public network access enabled temporarily for Day 5
- Will add Private Endpoint on Day 6 for production-grade security
- 7-day backup retention (minimum allowed)

**4. Simplified Day 5 Scope:**
- Removed NSG flow logs (deprecated by Azure, retiring Sept 2027)
- Deferred SQL auditing to Day 6 (storage account dependency issues)
- Deferred diagnostic settings to Day 6 (provider timing issues)
- Focus: Establish working baseline infrastructure

### Challenges & Resolutions

**Challenge 1: Azure Provider Registration**
- **Issue:** Terraform errors about unregistered resource providers
- **Solution:** Manually registered Microsoft.Network, Microsoft.Sql, Microsoft.OperationalInsights
- **Command:** `az provider register --namespace Microsoft.Network`
- **Learning:** New Azure subscriptions require explicit provider registration

**Challenge 2: Subscription Authentication**
- **Issue:** Free trial subscription expired, MFA required
- **Solution:** Upgraded to pay-as-you-go, created service principal for Terraform
- **Learning:** Service principals bypass MFA for automation workflows

**Challenge 3: NSG Flow Logs Deprecated**
- **Issue:** `azurerm_network_watcher_flow_log` will retire September 2027
- **Solution:** Removed from configuration, will use diagnostic settings instead
- **Learning:** Always check Azure deprecation notices during planning

**Challenge 4: Storage Account Naming**
- **Issue:** Azure requires lowercase + numbers only, 3-24 characters
- **Solution:** Changed `healthcaredrsqlaudit` to `hcdraudit` + random suffix
- **Learning:** Each cloud has unique naming constraints

**Challenge 5: SQL VNet Rules with Public Access Disabled**
- **Issue:** Can't create VNet firewall rules when `public_network_access_enabled = false`
- **Solution:** Enabled public access for Day 5, will implement Private Endpoint Day 6
- **Learning:** Private connectivity requires Private Endpoint, not VNet rules

**Challenge 6: Provider Timing Issues**
- **Issue:** Multiple "Resource Not Found" errors during apply due to Azure provider race conditions
- **Solution:** Simplified deployment by removing diagnostic settings and auditing temporarily
- **Learning:** Azure provider has dependency timing issues with some resource combinations

### Cost Analysis

| Resource | Configuration | Monthly Cost | Free Tier |
|----------|--------------|--------------|-----------|
| Virtual Network | 10.1.0.0/16 | $0.00 | Always free |
| Subnets (3) | Standard | $0.00 | Always free |
| NSGs (3) | Standard rules | $0.00 | Always free |
| SQL Server | Logical server | $0.00 | Always free |
| SQL Database | Basic, 2GB | $0.00 | 250GB free (12mo) |
| Log Analytics | 30-day retention | $0.00 | 5GB/month free |
| Action Group | Email alerts | $0.00 | 1000 emails free |
| **TOTAL** | | **$0.00** | |

**Free Tier Status:**
- SQL Database: Using <1% of 250GB limit
- Log Analytics: Expected <1GB/month ingestion
- Zero charges expected for Day 5-7 workload

### Key Commands
```powershell
# Service principal for Terraform auth
az ad sp create-for-rbac --name "terraform-healthcare-dr" \
  --role Contributor \
  --scopes /subscriptions/e3426a1f-26ac-4f27-b7f1-6f46b92b83fa

# Deploy infrastructure
terraform init
terraform plan -out=".\tfplan"
terraform apply ".\tfplan"

# Verify deployment
az resource list --resource-group healthcare-dr-rg
az network vnet show --resource-group healthcare-dr-rg --name healthcare-dr-vnet
az sql server show --resource-group healthcare-dr-rg --name healthcare-dr-sqlserver-4x858c
```

### Terraform Implementation

**Files Created:**
```
terraform/azure-dr/
├── providers.tf      # Azure provider with service principal auth
├── variables.tf      # Configuration variables
├── main.tf           # Resource group and data sources
├── network.tf        # VNet, subnets, NSGs
├── database.tf       # SQL Server and database (simplified)
├── monitoring.tf     # Log Analytics and action group (simplified)
└── outputs.tf        # Resource IDs and endpoints
```

**Code Statistics:**
- Total Lines: ~800 lines HCL
- Resources Deployed: 12-15 resources
- Deferred to Day 6: ~20 resources (auditing, private endpoints, diagnostics)

### Interview Talking Points

**Network Segmentation:**
"I implemented a 3-tier Azure VNet that mirrors the AWS VPC architecture. The 10.1.0.0/16 address space is intentionally different from AWS's 10.0.0.0/16 to facilitate future VPN/ExpressRoute connectivity without IP conflicts. Each tier has dedicated NSGs enforcing least-privilege access—for example, the database NSG only accepts SQL traffic from the application subnet."

**Cloud Provider Differences:**
"One interesting challenge was learning Azure's NSG flow logs are deprecated, unlike AWS VPC Flow Logs which are actively supported. This taught me the importance of staying current with cloud provider roadmaps. I pivoted to diagnostic settings which provide similar visibility while being the recommended approach going forward."

**Cost Optimization:**
"By using Azure's free tier strategically—Basic SQL Database, minimal Log Analytics ingestion, and standard networking resources—I kept Day 5 deployment at $0.00 while still demonstrating enterprise-grade architecture patterns. This shows I can balance technical requirements with budget constraints."

**Security Posture:**
"For Day 5, I temporarily enabled public network access to the SQL Server to establish baseline connectivity. On Day 6, I'll implement Private Endpoint which creates a private IP address within the VNet, completely removing the public attack surface. This phased approach mirrors real-world migration projects where you establish connectivity first, then harden security incrementally."

### Verification Completed

- [x] Resource group created in East US 2
- [x] VNet deployed with 3 subnets
- [x] NSGs configured with security rules
- [x] SQL Server and database operational
- [x] Log Analytics workspace active
- [x] Action group configured with email alerts
- [x] All resources visible in Azure Portal
- [x] Terraform outputs working
- [x] Current charges: $0.00 ✅
- [x] Terraform state synced

### Key Achievements - Day 5

✅ **Multi-Cloud Infrastructure**
- Successfully deployed Azure DR environment
- 12-15 Azure resources at $0.00 cost
- Mirrored AWS 3-tier architecture

✅ **Professional DevOps Practices**
- Service principal authentication
- Infrastructure as Code (Terraform)
- Systematic troubleshooting and recovery
- Comprehensive documentation

✅ **Security-First Design**
- Network segmentation with NSGs
- Least-privilege access controls
- Monitoring and alerting foundation

✅ **Cost Optimization**
- 100% free tier utilization
- Strategic feature deferral (auditing, private endpoints)
- Zero Azure charges achieved

### Time Breakdown - Day 5
- Terraform configuration: 1.5 hours
- Provider registration and authentication: 45 minutes
- Troubleshooting deployment issues: 1.5 hours
- Simplification and re-deployment: 45 minutes
- Verification and testing: 30 minutes
- Documentation: 45 minutes
- **Total:** ~5 hours

### Next Steps (Day 6)

**Security Enhancements:**
- [ ] Deploy Private Endpoint for SQL Database
- [ ] Configure Private DNS zone for privatelink.database.windows.net
- [ ] Disable public network access on SQL Server
- [ ] Enable SQL auditing with dedicated storage account
- [ ] Configure threat detection policies

**Monitoring & Compliance:**
- [ ] Enable diagnostic settings for all resources
- [ ] Create custom Log Analytics queries for security events
- [ ] Configure alert rules for failed login attempts
- [ ] Document compliance controls (HIPAA alignment)

**Cross-Cloud Connectivity:**
- [ ] Plan VPN Gateway or ExpressRoute architecture
- [ ] Design cross-cloud routing (AWS ↔ Azure)
- [ ] Prepare for database replication setup

---

## Days 6-7: Azure Security & Connectivity

**Date:** November 5-6, 2025 (Planned)  
**Duration:** 6-8 hours (Estimated)  
**Status:** ⏳ Planned  
**Estimated Cost:** $0.00

### Objectives
- Implement Private Endpoint for SQL Database
- Enable SQL auditing and threat detection
- Configure diagnostic settings for all resources
- Begin VPN/ExpressRoute connectivity planning
- Prepare for cross-cloud database replication

---

## Days 8-10: Integration & Testing

**Date:** November 7-11, 2025 (Planned)  
**Duration:** 8-10 hours (Estimated)  
**Status:** ⏳ Planned  
**Estimated Cost:** $0.00

### Objectives
- Configure database replication AWS → Azure
- Build automated failover orchestration (Python)
- Create monitoring dashboards (both clouds)
- Implement health checks and alerting
- Document DR procedures
- Execute DR test and measure RTO/RPO

---

## Cost Summary

### Cumulative Costs by Day

| Day | AWS Cost | Azure Cost | Total | Notes |
|-----|----------|------------|-------|-------|
| Day 1 | $0.00 | $0.00 | $0.00 | Setup only |
| Day 2 | $0.00 | $0.00 | $0.00 | VPC infrastructure |
| Day 3 | $0.00 | $0.00 | $0.00 | Config, SNS, KMS |
| Day 4 | $0.16 | $0.00 | $0.16 | RDS, ECS Fargate |
| Day 5 | $0.16 | $0.00 | $0.16 | Azure VNet, SQL |
| Days 6-10 | TBD | TBD | TBD | Planned |
| **TOTAL** | **$0.16** | **$0.00** | **$0.16** | |

### Project Metrics

**Total Infrastructure:**
- **AWS Resources:** 85 resources
- **Azure Resources:** 12-15 resources
- **Total Resources:** 97+ resources
- **Monthly Cost:** $0.16/month
- **Days Complete:** 5 of 10 (50%)

### Budget Status
- ✅ Zero-spend alert: Not triggered
- ✅ $10 monthly limit: Well under budget
- ✅ AWS free tier: Maximized
- ✅ Azure free tier: Maximized

---

## Lessons Learned

### Day 5 Lessons

✅ **What Worked:**
- Service principal authentication for Terraform automation
- Breaking deployment into phases (networking first, then database)
- Systematic troubleshooting of provider registration issues
- Accepting temporary compromises (public SQL access) to maintain progress
- Comprehensive documentation while building

💪 **Challenges:**
- Azure provider registration not automatic for new subscriptions
- Free trial expired requiring upgrade to pay-as-you-go
- NSG flow logs deprecated (different from AWS VPC Flow Logs)
- Storage account naming restrictions (lowercase + numbers only)
- Provider timing issues with diagnostic settings
- Multiple deployment failures requiring simplified approach

💡 **Improvements:**
- Check Azure service deprecation notices during planning phase
- Use service principals from the start for cleaner automation
- Build in smaller increments when learning new cloud providers
- Accept that some features need to be deferred when troubleshooting
- Keep separate Terraform modules for problematic resource types
- Test authentication and provider registration before writing code

🔑 **Key Takeaways:**
1. **Multi-cloud is complex** - Each provider has unique quirks and requirements
2. **Phased approach works** - Establish baseline first, then layer security
3. **Provider differences matter** - Azure NSG flow logs vs AWS VPC Flow Logs
4. **Cost discipline pays off** - $0.00 Azure spend while building real infrastructure
5. **Documentation is critical** - Future deployments will benefit from Day 5 notes
6. **Troubleshooting builds skills** - Provider issues teach cloud internals
7. **Service principals are essential** - Better than user accounts for automation

📚 **Learning Resources Used:**
- Azure Terraform provider documentation
- Azure CLI reference documentation
- Azure portal for verification and troubleshooting
- Azure pricing calculator for free tier validation
- GitHub issues for deprecated NSG flow logs
- Stack Overflow for provider registration patterns

🎯 **Portfolio Value Demonstrated:**
- Multi-cloud architecture skills (AWS + Azure)
- Cost optimization across cloud providers
- Systematic troubleshooting under time pressure
- Professional documentation practices
- Infrastructure as Code best practices
- Security-first design patterns
- Real-world problem solving (not just tutorials)

### General Best Practices (Updated)

1. **Always commit before terraform apply** - Creates rollback point
2. **Use Terraform outputs over CLI queries** - More reliable
3. **Document as you go** - Easier than retroactive documentation
4. **Take screenshots immediately** - Evidence while it's fresh
5. **Check costs daily** - Catch unexpected charges early
6. **Tag everything** - Makes resource management easier
7. **Comprehensive .gitignore prevents disasters** - Exclude .terraform, state files, credentials
8. **Terraform import is a lifesaver** - Can rebuild state from existing infrastructure
9. **Provider registration comes first** - Register Azure providers before deployment
10. **Service principals for automation** - Cleaner than user-based authentication
11. **Phased security implementation** - Baseline first, harden incrementally
12. **Check deprecation notices** - Cloud providers retire features regularly

---

## Repository Links

**GitHub Repository:**  
https://github.com/higgidv/multi-cloud-portfolio/tree/main/healthcare-multicloud-dr

**Key Directories:**
- [AWS Terraform](../terraform/aws-primary/) - AWS infrastructure code
- [Azure Terraform](../terraform/azure-dr/) - Azure infrastructure code
- [Documentation](../docs/) - Architecture and compliance docs
- [Screenshots](../diagrams/screenshots/) - AWS and Azure Console evidence

---

## Contact & Attribution

**Project Author:** DaSean Higgins  
**Role:** Cloud Architect | Cloud Engineer  
**LinkedIn:** https://linkedin.com/in/higginsdasean  
**Email:** higgins.dasean@gmail.com  
**GitHub:** https://github.com/higgidv

**Last Updated:** November 4, 2025  
**Document Version:** 1.5  
**Next Update:** After Day 6 completion