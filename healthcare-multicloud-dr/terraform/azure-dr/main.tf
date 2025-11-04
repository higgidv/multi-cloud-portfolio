# ============================================================================
# AZURE DR ENVIRONMENT - MAIN CONFIGURATION
# ============================================================================
# Purpose: Disaster Recovery environment for Healthcare FHIR application
# Region: East US (mirrors AWS us-east-1)
# Architecture: 3-tier VNet matching AWS VPC design
# ============================================================================

# Random suffix for globally unique resource names
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# ============================================================================
# RESOURCE GROUP
# ============================================================================

resource "azurerm_resource_group" "main" {
  name     = "${var.project_name}-rg"
  location = var.location
  tags     = var.tags
}

# ============================================================================
# DATA SOURCES
# ============================================================================

# Get current Azure subscription details
data "azurerm_subscription" "current" {}

# Get current client configuration
data "azurerm_client_config" "current" {}