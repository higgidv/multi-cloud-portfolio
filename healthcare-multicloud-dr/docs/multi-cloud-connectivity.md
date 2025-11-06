# Day 7: Multi-Cloud Connectivity Implementation

**Date:** November 5, 2025  
**Objective:** Establish Site-to-Site VPN between AWS Primary and Azure DR environments

## Overview

Implemented IPsec VPN tunnels to enable secure multi-cloud connectivity between AWS us-east-1 (10.0.0.0/16) and Azure East US 2 (10.1.0.0/16). This establishes the foundation for database replication and disaster recovery failover capabilities.

## Architecture Components

### Azure Side (DR Site)
- **VPN Gateway:** healthcare-dr-vpn-gateway (VpnGw1, Generation1)
- **Public IP:** 128.24.23.41
- **Gateway Subnet:** 10.1.255.0/27 (GatewaySubnet)
- **VPN Type:** Route-Based
- **Throughput:** Up to 100 Mbps

### AWS Side (Primary Site)
- **Virtual Private Gateway:** healthcare-vpn-gateway (vgw-09d9b8dc2d2b6bbfc)
- **Customer Gateway:** healthcare-azure-cgw (represents Azure endpoint)
- **VPN Connection:** healthcare-azure-vpn (vpn-0534acfe44f116fe8)
- **Tunnel Configuration:** Dual redundant tunnels
- **Routing:** Static routes to 10.1.0.0/16

## Network Flow
```
AWS VPC (10.0.0.0/16)
    ↕ [Virtual Private Gateway]
    ↕ [IPsec Tunnel 1 - Primary]
    ↕ [IPsec Tunnel 2 - Redundant]
    ↕ [Azure VPN Gateway]
    ↕
Azure VNet (10.1.0.0/16)
```

## Deployment Timeline

| Time | Activity | Status |
|------|----------|--------|
| 3:00 PM EST | Azure VPN Gateway deployment initiated | ✅ Complete |
| 3:45 PM EST | Azure Gateway operational | ✅ Complete |
| 4:30 PM EST | AWS VPN components deployed | ✅ Complete |
| 5:00 PM EST | IPsec tunnels established | ✅ Complete |
| 5:15 PM EST | Connectivity validation complete | ✅ Complete |
| 6:00 PM EST | Resources destroyed for cost control | ✅ Complete |

## Configuration Details

### Azure VPN Gateway Deployment

**Deployment Start:** November 5, 2025, 3:00 PM EST  
**Deployment Complete:** November 5, 2025, 3:45 PM EST  
**Duration:** 45 minutes  
**Public IP:** 128.24.23.41

**Terraform Resources:**
- azurerm_subnet.gateway (GatewaySubnet - 10.1.255.0/27)
- azurerm_public_ip.vpn_gateway (128.24.23.41)
- azurerm_virtual_network_gateway.vpn (VpnGw1, Generation1)

**Gateway Specifications:**
- SKU: VpnGw1
- Generation: Generation1
- Active-Active: Disabled (single instance)
- BGP: Disabled (using static routes)

### AWS VPN Configuration

**Deployment Start:** November 5, 2025, 4:30 PM EST  
**Deployment Complete:** November 5, 2025, 4:43 PM EST  
**Duration:** 13 minutes

**Terraform Resources:**
- aws_customer_gateway.azure (IP: 128.24.23.41, BGP ASN: 65000)
- aws_vpn_gateway.main (ID: vgw-09d9b8dc2d2b6bbfc)
- aws_vpn_connection.azure (ID: vpn-0534acfe44f116fe8)
- aws_vpn_gateway_attachment.main (VPC attachment)
- aws_route.private_to_azure (10.1.0.0/16 → VPN Gateway)

**Customer Gateway:**
- BGP ASN: 65000
- IP Address: 128.24.23.41 (Azure VPN Gateway)
- Type: ipsec.1

### Azure Local Network Gateways and Connections

**Local Network Gateway - Tunnel 1:**
- Name: healthcare-aws-lgw-tunnel1
- Gateway Address: 50.16.41.121
- Address Space: 10.0.0.0/16 (AWS VPC)

**Local Network Gateway - Tunnel 2:**
- Name: healthcare-aws-lgw-tunnel2
- Gateway Address: 52.2.3.246
- Address Space: 10.0.0.0/16 (AWS VPC)

**VPN Connections:**
- healthcare-azure-to-aws-tunnel1 (Primary)
- healthcare-azure-to-aws-tunnel2 (Redundant)

## IPsec Tunnel Configuration

**Tunnel 1:**
- AWS Endpoint: 50.16.41.121
- Inside CIDR: 169.254.43.60/30
- Pre-Shared Key: [STORED IN TERRAFORM STATE]
- Status: UP (established November 5, 2025, 5:15 PM EST)

**Tunnel 2:**
- AWS Endpoint: 52.2.3.246
- Inside CIDR: 169.254.103.140/30
- Pre-Shared Key: [STORED IN TERRAFORM STATE]
- Status: UP (established November 5, 2025, 5:15 PM EST)

**Encryption:** AES-256-GCM  
**Authentication:** Pre-Shared Key (PSK)  
**IKE Version:** IKEv2  
**Perfect Forward Secrecy:** Enabled  
**DPD Timeout:** 30 seconds

## Route Table Updates

### AWS Route Tables

**Private Route Table:**
- Destination: 10.1.0.0/16 → Target: Virtual Private Gateway (vgw-09d9b8dc2d2b6bbfc)
- Applied to: Private App and Private Data subnets

### Azure Route Tables

No custom route tables required. Azure VPN Gateway automatically handles routing for connected address spaces (10.0.0.0/16).

## Connectivity Testing

### Test Approach

Due to cost optimization, connectivity testing was limited to tunnel status verification rather than data plane testing with VMs. This approach validates:
- IPsec tunnel establishment (control plane)
- Route configuration
- Gateway availability

**Production environments would include:**
- VM-to-VM ping tests
- Application-level connectivity tests
- Bandwidth and latency measurements

### Tunnel Status Verification

**AWS Side:**
- Command: `aws ec2 describe-vpn-connections`
- Result: Both tunnels showing "UP" status
- Verification: Console screenshots captured

**Azure Side:**
- Command: `az network vpn-connection show`
- Result: Both connections showing "Connected" status
- Data Transfer: 0 bytes (expected - no data plane testing)

## Security Considerations

1. **Encryption:** AES-256-GCM for IPsec tunnel encryption
2. **Authentication:** Pre-shared keys (PSK) stored in Terraform state (encrypted at rest)
3. **Routing:** Static routes prevent route propagation beyond intended networks
4. **Firewall Rules:** NSG and Security Group rules restrict multi-cloud traffic to required ports only
5. **Key Management:** PSKs generated by AWS, securely transferred to Azure configuration
6. **Network Isolation:** Gateway subnet isolated from application subnets

## Cost Analysis

### VPN Gateway Costs

**Azure VPN Gateway (VpnGw1):**
- Gateway: $0.15/hour = ~$109/month
- Egress: $0.05/GB for data transfer to AWS

**AWS VPN Connection:**
- Connection: $0.05/hour = ~$36/month
- Data Transfer: $0.09/GB outbound

**Total VPN Cost:** ~$145/month for full-time operation

**Day 7 Actual Cost:**
- Azure VPN Gateway: 6 hours × $0.15 = $0.90
- AWS VPN Connection: 6 hours × $0.05 = $0.30
- Data Transfer: $0.00 (no data plane testing)
- **Total Day 7 Cost: $1.20**

### Cost Management Decision

After successful validation, destroyed all VPN infrastructure and Azure DR resources:
- **Ongoing cost if retained:** ~$145/month for VPN + ~$30/month for Azure SQL = $175/month
- **Cost savings:** $175/month while not actively needed
- **Terraform code preserved:** Complete infrastructure as code for rapid redeployment (~30 minutes)
- **Portfolio evidence:** Screenshots + documentation demonstrate capability without ongoing costs

This decision reflects production-grade cost management: maintaining DR infrastructure as code and deploying only during testing/failover scenarios.

## Challenges and Solutions

### Challenge 1: Gateway Deployment Time
**Issue:** Azure VPN Gateway deployment takes 30-45 minutes  
**Solution:** Initiated Azure deployment first, worked on AWS configuration in parallel. Used deployment time productively for documentation and planning next steps.  
**Best Practice:** Always start long-running resource deployments first, then work on faster components concurrently.

### Challenge 2: VPN Tunnels Down - PSK Mismatch
**Issue:** Both IPsec tunnels remained DOWN for 15+ minutes after initial deployment. No clear error messages in Azure or AWS consoles.  
**Root Cause:** Pre-shared keys in Azure `vpn-connection.tf` didn't match AWS-generated keys exactly. Initial configuration had placeholder/incorrect PSK values.  
**Solution:** 
1. Retrieved actual PSKs from AWS using `terraform output -raw aws_vpn_tunnel1_preshared_key`
2. Updated Azure `vpn-connection.tf` with correct keys:
   - Tunnel 1: vJQ3KegGYz6ohEg6qx7f34r57kFIIdpt
   - Tunnel 2: FJ3GK4tQub0L0XzFLw5FXIXk9aR.8VT8
3. Redeployed Azure VPN connections using `terraform apply`
4. Tunnels established within 3 minutes after PSK correction

**Lesson:** Always verify security credentials match exactly between cloud providers. Copy-paste errors or placeholder values in PSKs will prevent tunnel establishment with no clear error messages. Use `terraform output` commands to retrieve exact values rather than manual transcription.

### Challenge 3: PowerShell Terraform Syntax Issues
**Issue:** Targeted destroy commands failing with "too many command line arguments" error  
**Root Cause:** PowerShell interprets periods in resource names (e.g., `azurerm_virtual_network_gateway.vpn`) as command separators  
**Solution:** 
- Option 1: Use quotes around resource names: `terraform destroy -target="azurerm_virtual_network_gateway.vpn"`
- Option 2: Use full destroy for Azure (since all resources needed to be destroyed anyway)  
**Lesson:** PowerShell syntax differs from bash/zsh. When using Terraform in Windows PowerShell, quote resource names containing special characters.

## Next Steps (Day 8)

1. Rebuild Azure DR infrastructure from Terraform (30 minutes)
2. Configure AWS DMS (Database Migration Service)
3. Set up replication instance (dms.t3.micro - free tier)
4. Create source and target endpoints (AWS RDS PostgreSQL → Azure SQL)
5. Configure replication task for continuous data sync
6. Test initial data load and ongoing replication

## Screenshots

### AWS VPN Connection - Tunnel Status
![AWS VPN Tunnels UP](../screenshots/aws-vpn-tunnels-up-status.png)

*Both tunnels showing UP status with timestamps. Tunnel 1: 50.16.41.121 (UP), Tunnel 2: 52.2.3.246 (UP). Status verified November 5, 2025.*

### Azure VPN Connections - Connected Status
![Azure VPN Tunnel 1 Connected](../screenshots/azure-vpn-tunnel1-connected.png)

*Azure connection showing "Connected" status to AWS tunnel endpoint (50.16.41.121). Virtual network gateway: healthcare-dr-vpn-gateway.*

![Azure VPN Tunnel 2 Connected](../screenshots/azure-vpn-tunnel2-connected.png)

*Azure connection showing "Connected" status to AWS tunnel endpoint (52.2.3.246). Redundant tunnel for high availability.*

### AWS Virtual Private Gateway
![AWS VPN Gateway](../screenshots/aws-vpn-connection-overview.png)

*AWS VPN connection overview showing Available state, Customer Gateway (128.24.23.41), and Virtual Private Gateway attachment.*

## Lessons Learned

1. **VPN Gateway Deployment Time:** Azure VPN Gateways take 30-45 minutes to deploy, significantly longer than most other resources. Plan accordingly and use this time for parallel work (AWS configuration, documentation).

2. **Pre-Shared Key Accuracy:** IPsec tunnels are extremely sensitive to PSK matching. Even a single character difference prevents tunnel establishment. Always copy PSKs directly from `terraform output` commands rather than manual transcription.

3. **PowerShell Terraform Syntax:** When using targeted destroy in PowerShell, resource names with periods require quotes: `terraform destroy -target="resource.name"`. The `-auto-approve` flag without targets destroys ALL resources in the directory - use with caution.

4. **Cost Management Strategy:** For portfolio/learning projects, deploy expensive networking resources (VPN Gateways ~$145/month) only during active testing. Destroy after validation and preserve infrastructure as code. Screenshots and Terraform configurations provide portfolio evidence without ongoing costs.

5. **Tunnel Status Monitoring:** VPN tunnels may take 5-10 minutes after configuration to establish. Check both AWS (`describe-vpn-connections`) and Azure (`vpn-connection show`) status. Tunnels typically show DOWN initially while negotiating IPsec parameters. Be patient and verify PSKs before troubleshooting further.

6. **Route-Based vs Policy-Based VPN:** Used route-based VPN for flexibility. Static routes provide explicit control over multi-cloud traffic patterns and are easier to troubleshoot than dynamic routing protocols (BGP).

7. **Redundant Tunnels for HA:** AWS automatically provisions two tunnel endpoints for high availability. If one tunnel fails, traffic automatically fails over to the second tunnel. This is critical for production DR scenarios.

8. **Infrastructure as Code Value:** Destroying resources after testing doesn't lose work when using Terraform. Complete infrastructure can be redeployed identically in 30-45 minutes, making temporary deployments for validation a viable cost optimization strategy.

## References

- [Azure VPN Gateway Documentation](https://learn.microsoft.com/en-us/azure/vpn-gateway/)
- [AWS Site-to-Site VPN](https://docs.aws.amazon.com/vpn/)
- [IPsec Tunnel Configuration](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-devices)
- [AWS-Azure VPN Interoperability](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-devices#validated-vpn-devices)