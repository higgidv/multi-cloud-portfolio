# ============================================================================
# SNS Topics - Compliance Alert Notifications
# ============================================================================
# Simple Notification Service for compliance violations and security alerts.
# Integrates with AWS Config to notify you immediately of any non-compliant
# resources.

# Main compliance alerts topic
resource "aws_sns_topic" "compliance_alerts" {
  name              = "${var.project_name}-compliance-alerts"
  display_name      = "Healthcare Project Compliance Alerts"
  kms_master_key_id = aws_kms_key.healthcare.id

  tags = {
    Name    = "${var.project_name}-compliance-alerts"
    Project = var.project_name
    Purpose = "HIPAA compliance notifications"
  }
}

# Email subscription - Update with your email
resource "aws_sns_topic_subscription" "compliance_email" {
  topic_arn = aws_sns_topic.compliance_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# ============================================================================
# Outputs
# ============================================================================

output "sns_topic_arn" {
  description = "ARN of the compliance alerts SNS topic"
  value       = aws_sns_topic.compliance_alerts.arn
}