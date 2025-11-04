# ============================================================================
# AZURE MONITOR AND LOG ANALYTICS
# ============================================================================
# Simplified for initial deployment - diagnostic settings causing issues
# Will add back after core infrastructure is stable
# ============================================================================

# ============================================================================
# LOG ANALYTICS WORKSPACE
# ============================================================================

resource "azurerm_log_analytics_workspace" "main" {
  count               = var.enable_monitoring ? 1 : 0
  name                = "${var.project_name}-logs"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days
  
  tags = var.tags
}

# ============================================================================
# ACTION GROUP FOR ALERTS
# ============================================================================

resource "azurerm_monitor_action_group" "security_alerts" {
  count               = var.enable_monitoring ? 1 : 0
  name                = "${var.project_name}-security-alerts"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "SecAlerts"

  email_receiver {
    name          = "SendToAdmin"
    email_address = "dasehigg@gmail.com"
  }

  tags = var.tags
}

# Diagnostic settings and solutions temporarily removed due to provider issues
# Will add back in Day 6 after core infrastructure is stable