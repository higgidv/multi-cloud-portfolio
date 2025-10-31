# ============================================================================
# KMS Encryption Keys - HIPAA 164.312(a)(2)(iv)
# ============================================================================
# Customer-managed keys for encryption at rest. Required for HIPAA compliance
# to maintain control over encryption keys and enable key rotation.

# Main encryption key for healthcare data
resource "aws_kms_key" "healthcare" {
  description             = "${var.project_name} - Master encryption key for healthcare data"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = {
    Name    = "${var.project_name}-master-key"
    Project = var.project_name
    Purpose = "HIPAA-compliant encryption"
  }
}

# Alias for easier reference
resource "aws_kms_alias" "healthcare" {
  name          = "alias/${var.project_name}-healthcare"
  target_key_id = aws_kms_key.healthcare.key_id
}

# ============================================================================
# Outputs for Reference
# ============================================================================

output "kms_key_id" {
  description = "ID of the KMS master key"
  value       = aws_kms_key.healthcare.id
}

output "kms_key_arn" {
  description = "ARN of the KMS master key"
  value       = aws_kms_key.healthcare.arn
}