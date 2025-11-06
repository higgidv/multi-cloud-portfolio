# Azure Local Network Gateway and VPN Connection to AWS
# Represents the AWS VPN endpoint for Azure's perspective

# Local Network Gateway - Tunnel 1 (Primary)
resource "azurerm_local_network_gateway" "aws_tunnel1" {
  name                = "healthcare-aws-lgw-tunnel1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  gateway_address     = "50.16.41.121"  # AWS Tunnel 1 IP
  address_space       = ["10.0.0.0/16"]  # AWS VPC CIDR
  
  tags = {
    Environment = "DR"
    Project     = "Healthcare-MultiCloud"
    ManagedBy   = "Terraform"
    Purpose     = "AWS Primary Site - Tunnel 1"
  }
}

# Local Network Gateway - Tunnel 2 (Redundant)
resource "azurerm_local_network_gateway" "aws_tunnel2" {
  name                = "healthcare-aws-lgw-tunnel2"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  gateway_address     = "52.2.3.246"  # AWS Tunnel 2 IP
  address_space       = ["10.0.0.0/16"]  # AWS VPC CIDR
  
  tags = {
    Environment = "DR"
    Project     = "Healthcare-MultiCloud"
    ManagedBy   = "Terraform"
    Purpose     = "AWS Primary Site - Tunnel 2"
  }
}

# VPN Connection - Tunnel 1 (Primary)
resource "azurerm_virtual_network_gateway_connection" "aws_tunnel1" {
  name                = "healthcare-azure-to-aws-tunnel1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn.id
  local_network_gateway_id   = azurerm_local_network_gateway.aws_tunnel1.id
  
  shared_key = "VjQ3KgqGYz6ohEg6qx7f34rS7KF1Idpt"  # AWS Tunnel 1 PSK
  
  tags = {
    Environment = "DR"
    Project     = "Healthcare-MultiCloud"
    ManagedBy   = "Terraform"
    Purpose     = "Primary VPN Tunnel to AWS"
  }
}

# VPN Connection - Tunnel 2 (Redundant)
resource "azurerm_virtual_network_gateway_connection" "aws_tunnel2" {
  name                = "healthcare-azure-to-aws-tunnel2"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn.id
  local_network_gateway_id   = azurerm_local_network_gateway.aws_tunnel2.id
  
  shared_key = "F136K4tQwB0L0XzFLwSFXI3X9aR.8VT8"  # AWS Tunnel 2 PSK 
  
  tags = {
    Environment = "DR"
    Project     = "Healthcare-MultiCloud"
    ManagedBy   = "Terraform"
    Purpose     = "Redundant VPN Tunnel to AWS"
  }
}

# Outputs for verification
output "vpn_tunnel1_status" {
  description = "VPN Tunnel 1 Connection Status"
  value       = azurerm_virtual_network_gateway_connection.aws_tunnel1.id
}

output "vpn_tunnel2_status" {
  description = "VPN Tunnel 2 Connection Status"
  value       = azurerm_virtual_network_gateway_connection.aws_tunnel2.id
}