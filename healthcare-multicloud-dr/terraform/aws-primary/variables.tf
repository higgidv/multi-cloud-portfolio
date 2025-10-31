# ============================================================================
# Core Variables
# ============================================================================

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "healthcare-hipaa"
}

variable "aws_region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# ============================================================================
# Network Variables
# ============================================================================

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zone" {
  description = "Availability zone for subnet placement"
  type        = string
  default     = "us-east-1a"
}

# ============================================================================
# Logging Variables
# ============================================================================

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = true
}

# ============================================================================
# Tagging Variables
# ============================================================================

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "Healthcare Multi-Cloud DR"
    ManagedBy   = "Terraform"
    Environment = "Development"
    Owner       = "DaSean Higgins"
    Purpose     = "Portfolio Demonstration"
    Compliance  = "HIPAA"
  }
}

# ============================================================================
# Day 3 Variables - Compliance & Alerting
# ============================================================================

variable "alert_email" {
  description = "Email address for compliance alert notifications"
  type        = string
  default     = "your-email@example.com"  # CHANGE THIS TO YOUR EMAIL
}