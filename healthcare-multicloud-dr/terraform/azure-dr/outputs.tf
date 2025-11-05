# ============================================================================
# OUTPUTS - AZURE DR ENVIRONMENT
# ============================================================================

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.main.id
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "public_subnet_id" {
  description = "ID of public subnet"
  value       = azurerm_subnet.public.id
}

output "private_app_subnet_id" {
  description = "ID of private app subnet"
  value       = azurerm_subnet.private_app.id
}

output "private_data_subnet_id" {
  description = "ID of private data subnet"
  value       = azurerm_subnet.private_data.id
}

output "public_nsg_id" {
  description = "ID of public NSG"
  value       = azurerm_network_security_group.public.id
}

output "app_nsg_id" {
  description = "ID of application NSG"
  value       = azurerm_network_security_group.app.id
}

output "database_nsg_id" {
  description = "ID of database NSG"
  value       = azurerm_network_security_group.database.id
}

output "subscription_id" {
  description = "Azure subscription ID"
  value       = data.azurerm_subscription.current.subscription_id
  sensitive   = true
}

output "log_analytics_workspace_id" {
  description = "ID of Log Analytics workspace"
  value       = var.enable_monitoring ? azurerm_log_analytics_workspace.main[0].id : null
}

output "log_analytics_workspace_name" {
  description = "Name of Log Analytics workspace"
  value       = var.enable_monitoring ? azurerm_log_analytics_workspace.main[0].name : null
}

# SQL Database outputs
output "sql_server_name" {
  description = "Name of Azure SQL Server"
  value       = azurerm_mssql_server.main.name
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of SQL Server"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "sql_database_name" {
  description = "Name of Azure SQL Database"
  value       = azurerm_mssql_database.main.name
}

output "sql_database_id" {
  description = "ID of Azure SQL Database"
  value       = azurerm_mssql_database.main.id
}

# ============================================================================
# DAY 6: SECURITY OUTPUTS
# ============================================================================

output "sql_private_endpoint_ip" {
  description = "Private IP address of SQL Server Private Endpoint"
  value       = try(azurerm_private_endpoint.sql.private_service_connection[0].private_ip_address, "Not deployed yet")
}

output "sql_private_dns_zone" {
  description = "Private DNS zone for SQL Server"
  value       = try(azurerm_private_dns_zone.sql.name, "Not deployed yet")
}

output "sql_audit_storage_account" {
  description = "Storage account for SQL audit logs"
  value       = try(azurerm_storage_account.sql_audit.name, "Not deployed yet")
}