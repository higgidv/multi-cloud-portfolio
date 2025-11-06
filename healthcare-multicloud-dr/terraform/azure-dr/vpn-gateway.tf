# VPN Gateway Configuration for Cross-Cloud Connectivity
# This enables Site-to-Site VPN between Azure (DR) and AWS (Primary)

# Gateway Subnet (required for VPN Gateway)
resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"  # Name must be exactly "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.1.255.0/27"]  # Dedicated /27 subnet for gateway
}

# Public IP for VPN Gateway
resource "azurerm_public_ip" "vpn_gateway" {
  name                = "healthcare-dr-vpn-pip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"  # Required for VPN Gateway
  sku                 = "Standard"
  
  tags = {
    Environment = "DR"
    Project     = "Healthcare-MultiCloud"
    ManagedBy   = "Terraform"
    Purpose     = "VPN Gateway Public IP"
  }
}

# VPN Gateway (VpnGw1 Generation 1 - cheapest option)
resource "azurerm_virtual_network_gateway" "vpn" {
  name                = "healthcare-dr-vpn-gateway"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  
  type     = "Vpn"
  vpn_type = "RouteBased"
  
  # VpnGw1 Generation1 - $36/month for VPN connection
  sku           = "VpnGw1"
  generation    = "Generation1"
  active_active = false
  enable_bgp    = false
  
  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn_gateway.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway.id
  }
  
  tags = {
    Environment = "DR"
    Project     = "Healthcare-MultiCloud"
    ManagedBy   = "Terraform"
    Purpose     = "Site-to-Site VPN to AWS"
  }
}

# Output for AWS configuration
output "azure_vpn_gateway_ip" {
  description = "Azure VPN Gateway Public IP for AWS Customer Gateway"
  value       = azurerm_public_ip.vpn_gateway.ip_address
}

output "azure_gateway_id" {
  description = "Azure VPN Gateway ID"
  value       = azurerm_virtual_network_gateway.vpn.id
}