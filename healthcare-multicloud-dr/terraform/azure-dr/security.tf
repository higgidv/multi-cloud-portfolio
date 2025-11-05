# ============================================================================
# AZURE SECURITY HARDENING
# ============================================================================
# Purpose: Private Endpoint, SQL Auditing, Threat Protection, Diagnostics
# Prerequisites: Infrastructure fully deployed
# ============================================================================

# ============================================================================
# PRIVATE DNS ZONE FOR SQL DATABASE
# ============================================================================
# Creates privatelink.database.windows.net zone for Private Endpoint DNS resolution

resource "azurerm_private_dns_zone" "sql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

# Link Private DNS Zone to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "sql" {
  name                  = "${var.project_name}-sql-dns-link"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = azurerm_virtual_network.main.id
  registration_enabled  = false
  tags                  = var.tags
}

# ============================================================================
# PRIVATE ENDPOINT FOR SQL DATABASE
# ============================================================================
# Deploys Private Endpoint in private-data-subnet for secure SQL access

resource "azurerm_private_endpoint" "sql" {
  name                = "${var.project_name}-sql-private-endpoint"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = azurerm_subnet.private_data.id
  tags                = var.tags

  private_service_connection {
    name                           = "${var.project_name}-sql-private-connection"
    private_connection_resource_id = azurerm_mssql_server.main.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }

  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sql.id]
  }

  # Ensure DNS zone link is ready before creating endpoint
  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.sql
  ]
}

# ============================================================================
# SQL AUDIT STORAGE ACCOUNT
# ============================================================================
# Storage account for SQL Server audit logs (HIPAA compliance requirement)

resource "azurerm_storage_account" "sql_audit" {
  name                     = "hcdraudit${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  # Secure storage configuration
  public_network_access_enabled   = true # Required for audit log writes
  allow_nested_items_to_be_public = false

  # Soft delete for audit log protection
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  tags = var.tags
}

# Storage container for audit logs
resource "azurerm_storage_container" "sql_audit" {
  name                  = "sqlauditlogs"
  storage_account_name  = azurerm_storage_account.sql_audit.name
  container_access_type = "private"
}

# ============================================================================
# SQL SERVER EXTENDED AUDITING
# ============================================================================
# Server-level auditing captures all database operations

resource "azurerm_mssql_server_extended_auditing_policy" "main" {
  server_id                               = azurerm_mssql_server.main.id
  storage_endpoint                        = azurerm_storage_account.sql_audit.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.sql_audit.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 7
  log_monitoring_enabled                  = true

  depends_on = [
    azurerm_storage_container.sql_audit
  ]
}

# ============================================================================
# SQL DATABASE EXTENDED AUDITING
# ============================================================================
# Database-level auditing for FHIR database

resource "azurerm_mssql_database_extended_auditing_policy" "main" {
  database_id                             = azurerm_mssql_database.main.id
  storage_endpoint                        = azurerm_storage_account.sql_audit.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.sql_audit.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 7
  log_monitoring_enabled                  = true

  depends_on = [
    azurerm_storage_container.sql_audit,
    azurerm_mssql_server_extended_auditing_policy.main
  ]
}

# ============================================================================
# ADVANCED THREAT PROTECTION (Microsoft Defender for SQL)
# ============================================================================
# Note: This may incur costs outside free tier - verify in portal

resource "azurerm_mssql_server_security_alert_policy" "main" {
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_mssql_server.main.name
  state               = "Enabled"

  # Alert on critical security events
  disabled_alerts = []

  # Send alerts to email
  email_account_admins = true
  email_addresses      = ["dasehigg@gmail.com"]

  retention_days = 7

  depends_on = [
    azurerm_mssql_server_extended_auditing_policy.main
  ]
}

# ============================================================================
# DIAGNOSTIC SETTINGS - SQL SERVER
# ============================================================================
# Send SQL Server metrics to Log Analytics
# Note: Audit logs go to storage account via Extended Auditing, not diagnostic settings

resource "azurerm_monitor_diagnostic_setting" "sql_server" {
  name                       = "${var.project_name}-sqlserver-diagnostics"
  target_resource_id         = azurerm_mssql_server.main.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main[0].id

  # Use enabled_metric instead of deprecated metric block
  enabled_metric {
    category = "AllMetrics"
  }

  depends_on = [
    azurerm_private_endpoint.sql,
    azurerm_mssql_server_extended_auditing_policy.main
  ]
}

# ============================================================================
# DIAGNOSTIC SETTINGS - SQL DATABASE
# ============================================================================
# Send FHIR database telemetry to Log Analytics

resource "azurerm_monitor_diagnostic_setting" "sql_database" {
  name                       = "${var.project_name}-sqldb-diagnostics"
  target_resource_id         = azurerm_mssql_database.main.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main[0].id

  enabled_log {
    category = "SQLInsights"
  }

  enabled_log {
    category = "Errors"
  }

  enabled_log {
    category = "Deadlocks"
  }

  enabled_log {
    category = "Timeouts"
  }

  enabled_metric {
    category = "Basic"
  }

  depends_on = [
    azurerm_private_endpoint.sql,
    azurerm_mssql_database_extended_auditing_policy.main
  ]
}

# ============================================================================
# LOG ANALYTICS ALERT RULES
# ============================================================================
# Alert on failed SQL authentication attempts (potential security breach)
# NOTE: Commented out for Day 6 - audit logs flow to storage account, not Log Analytics
# Will revisit alert configuration on Day 7 after validating audit log schema

# resource "azurerm_monitor_scheduled_query_rules_alert_v2" "failed_sql_logins" {
#   name                = "${var.project_name}-failed-sql-logins-alert"
#   resource_group_name = azurerm_resource_group.main.name
#   location            = azurerm_resource_group.main.location
#
#   evaluation_frequency = "PT5M"
#   window_duration      = "PT5M"
#   scopes               = [azurerm_log_analytics_workspace.main[0].id]
#   severity             = 2
#
#   criteria {
#     query                   = <<-QUERY
#       AzureDiagnostics
#       | where ResourceProvider == "MICROSOFT.SQL"
#       | where Category == "SQLSecurityAuditEvents"
#       | where OperationName has "FAILED"
#       | summarize FailedAttempts = count() by Resource, CallerIpAddress, bin(TimeGenerated, 5m)
#       | where FailedAttempts > 5
#     QUERY
#     time_aggregation_method = "Count"
#     threshold               = 1
#     operator                = "GreaterThan"
#
#     failing_periods {
#       minimum_failing_periods_to_trigger_alert = 1
#       number_of_evaluation_periods             = 1
#     }
#   }
#
#   action {
#     action_groups = [azurerm_monitor_action_group.security_alerts[0].id]
#   }
#
#   description = "Alert when more than 5 failed SQL authentication attempts detected from same IP within 5 minutes"
#   enabled     = true
#   tags        = var.tags
#
#   depends_on = [
#     azurerm_monitor_diagnostic_setting.sql_server
#   ]
# }