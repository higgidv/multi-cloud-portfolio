variable "azure_subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "healthcare-dr"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dr"
}

variable "location" {
  description = "Azure region for DR environment"
  type        = string
  default     = "eastus2"
}

variable "vnet_cidr" {
  description = "CIDR block for Azure VNet (different from AWS 10.0.0.0/16)"
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "private_app_subnet_cidr" {
  description = "CIDR block for private app subnet"
  type        = string
  default     = "10.1.2.0/24"
}

variable "private_data_subnet_cidr" {
  description = "CIDR block for private data subnet"
  type        = string
  default     = "10.1.3.0/24"
}

variable "sql_admin_username" {
  description = "Azure SQL Database administrator username"
  type        = string
  default     = "sqladmin"
  sensitive   = true
}

variable "sql_admin_password" {
  description = "Azure SQL Database administrator password"
  type        = string
  sensitive   = true
}

variable "enable_monitoring" {
  description = "Enable Azure Monitor and Log Analytics"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "Log Analytics workspace retention days (free tier supports 7 days)"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project     = "Healthcare-Multi-Cloud-DR"
    Environment = "DR"
    ManagedBy   = "Terraform"
    CostCenter  = "Portfolio"
    Compliance  = "HIPAA"
  }
}

variable "azure_client_id" {
  description = "Azure Service Principal App ID"
  type        = string
  sensitive   = true
}

variable "azure_client_secret" {
  description = "Azure Service Principal Password"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}