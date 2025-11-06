# AWS VPN Configuration for Multi-Cloud Connectivity
# Customer Gateway represents Azure VPN Gateway endpoint

# Customer Gateway (represents Azure VPN Gateway)
# Note: You'll need to update customer_gateway_ip after Azure deployment
resource "aws_customer_gateway" "azure" {
  bgp_asn    = 65000
  ip_address = "128.24.23.41"
  type       = "ipsec.1"
  
  tags = merge(var.common_tags, {
    Name    = "healthcare-azure-cgw"
    Purpose = "Azure DR Site Connection"
  })
}

# Virtual Private Gateway (AWS side of VPN)
resource "aws_vpn_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = merge(var.common_tags, {
    Name    = "healthcare-vpn-gateway"
    Purpose = "Site-to-Site VPN to Azure DR"
  })
}

# VPN Gateway Attachment
resource "aws_vpn_gateway_attachment" "main" {
  vpc_id         = aws_vpc.main.id
  vpn_gateway_id = aws_vpn_gateway.main.id
}

# Site-to-Site VPN Connection
resource "aws_vpn_connection" "azure" {
  vpn_gateway_id      = aws_vpn_gateway.main.id
  customer_gateway_id = aws_customer_gateway.azure.id
  type                = "ipsec.1"
  static_routes_only  = true
  
  tags = merge(var.common_tags, {
    Name    = "healthcare-azure-vpn"
    Purpose = "Primary to DR Site VPN"
  })
}

# Static route to Azure VNet
resource "aws_vpn_connection_route" "azure_vnet" {
  destination_cidr_block = "10.1.0.0/16"  # Azure VNet CIDR
  vpn_connection_id      = aws_vpn_connection.azure.id
}

# Update route tables to route Azure traffic through VPN
resource "aws_route" "private_app_to_azure" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "10.1.0.0/16"
  gateway_id             = aws_vpn_gateway.main.id
  
  depends_on = [aws_vpn_gateway_attachment.main]
}

resource "aws_route" "private_to_azure" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "10.1.0.0/16"
  gateway_id             = aws_vpn_gateway.main.id
  
  depends_on = [aws_vpn_gateway_attachment.main]
}

# Outputs for documentation
output "aws_vpn_connection_id" {
  description = "VPN Connection ID"
  value       = aws_vpn_connection.azure.id
}

output "aws_vpn_tunnel1_address" {
  description = "VPN Tunnel 1 Outside IP Address"
  value       = aws_vpn_connection.azure.tunnel1_address
}

output "aws_vpn_tunnel2_address" {
  description = "VPN Tunnel 2 Outside IP Address"
  value       = aws_vpn_connection.azure.tunnel2_address
}

output "aws_vpn_tunnel1_preshared_key" {
  description = "VPN Tunnel 1 Pre-Shared Key"
  value       = aws_vpn_connection.azure.tunnel1_preshared_key
  sensitive   = true
}

output "aws_vpn_tunnel2_preshared_key" {
  description = "VPN Tunnel 2 Pre-Shared Key"
  value       = aws_vpn_connection.azure.tunnel2_preshared_key
  sensitive   = true
}

# Enable route propagation on private route tables
resource "aws_vpn_gateway_route_propagation" "private" {
  vpn_gateway_id = aws_vpn_gateway.main.id
  route_table_id = aws_route_table.private.id
}

resource "aws_vpn_gateway_route_propagation" "private_data" {
  vpn_gateway_id = aws_vpn_gateway.main.id
  route_table_id = aws_route_table.private.id
}