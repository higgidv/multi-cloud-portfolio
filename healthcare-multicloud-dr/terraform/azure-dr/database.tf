# ============================================================================
# AZURE SQL DATABASE - DAY 5 FOUNDATION + DAY 6 SECURITY PREP
# ============================================================================
# Purpose: DR database for FHIR data (will replicate from AWS RDS)
# Tier: Basic (eligible for 12-month free tier: 250GB storage)
# Day 5: Core database deployment with public access
# Day 6: Private Endpoint, auditing, threat protection added via security.tf
# ============================================================================

# ============================================================================
# SQL SERVER (Logical Server)
# ============================================================================

resource "azurerm_mssql_server" "main" {
  name                         = "${var.project_name}-sqlserver-${random_string.suffix.result}"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"

  # Enable Azure AD authentication
  azuread_administrator {
    login_username = data.azurerm_client_config.current.object_id
    object_id      = data.azurerm_client_config.current.object_id
  }

  # Public access enabled for Day 5
  # Will remain enabled alongside Private Endpoint for Day 6
  # In production, would disable after Private Endpoint validation
  public_network_access_enabled = true

  # Prevent Terraform from trying to recreate server if public access changes
  lifecycle {
    ignore_changes = [public_network_access_enabled]
  }

  tags = var.tags
}

# ============================================================================
# SQL DATABASE
# ============================================================================

resource "azurerm_mssql_database" "main" {
  name           = "${var.project_name}-fhirdb"
  server_id      = azurerm_mssql_server.main.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  sku_name       = "Basic"
  max_size_gb    = 2
  zone_redundant = false

  # Short term backup retention (7 days minimum)
  short_term_retention_policy {
    retention_days = 7
  }

  tags = var.tags
}

# ============================================================================
# SQL FIREWALL RULES
# ============================================================================

# Allow Azure services to access SQL Server
# Required for audit log writes to storage account
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Allow your IP for testing (optional - add your public IP)
# resource "azurerm_mssql_firewall_rule" "allow_my_ip" {
#   name             = "AllowMyIP"
#   server_id        = azurerm_mssql_server.main.id
#   start_ip_address = "174.64.46.74"
#   end_ip_address   = "174.64.46.74"
# }