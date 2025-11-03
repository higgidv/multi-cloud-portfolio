# RDS PostgreSQL for FHIR Server
# Free tier: db.t3.micro, 20GB storage, 750 hours/month

# DB Subnet Group - spans multiple AZs in private data subnets
resource "aws_db_subnet_group" "fhir" {
  name       = "fhir-db-subnet-group"
  subnet_ids = [
    aws_subnet.private_data.id,
    aws_subnet.private_data_2.id
  ]

  tags = {
    Name        = "FHIR Database Subnet Group"
    Project     = "Healthcare-DR"
    Environment = "Production"
    Compliance  = "HIPAA"
  }
}

# DB Parameter Group - optimized for FHIR workloads
resource "aws_db_parameter_group" "fhir_postgres" {
  name   = "fhir-postgres13"
  family = "postgres13"

  # Only include parameters that can be set at creation
  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }

  tags = {
    Name    = "FHIR PostgreSQL Parameters"
    Project = "Healthcare-DR"
  }
}

# Generate random password for RDS
resource "random_password" "db_password" {
  length  = 32
  special = true
  # Exclude characters that might cause issues in connection strings
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Store RDS credentials in Secrets Manager
resource "aws_secretsmanager_secret" "rds_credentials" {
  name                    = "healthcare-dr/rds/fhir-credentials"
  description             = "RDS PostgreSQL credentials for FHIR server"
  recovery_window_in_days = 7

  tags = {
    Name       = "FHIR Database Credentials"
    Project    = "Healthcare-DR"
    Compliance = "HIPAA"
  }
}

resource "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = "fhiradmin"
    password = random_password.db_password.result
    engine   = "postgres"
    host     = aws_db_instance.fhir.address
    port     = aws_db_instance.fhir.port
    dbname   = "fhirdb"
  })
}

# RDS PostgreSQL Instance
resource "aws_db_instance" "fhir" {
  identifier     = "healthcare-fhir-db"
  engine         = "postgres"
  engine_version = "13.16"
  instance_class = "db.t3.micro"

  # Storage configuration - free tier
  allocated_storage     = 20
  max_allocated_storage = 0 # Disable auto-scaling to stay in free tier
  storage_type          = "gp2"
  storage_encrypted     = true
  kms_key_id            = aws_kms_key.healthcare.arn

  # Database configuration
  db_name  = "fhirdb"
  username = "fhiradmin"
  password = random_password.db_password.result
  port     = 5432

  # Network configuration
  db_subnet_group_name   = aws_db_subnet_group.fhir.name
  vpc_security_group_ids = [aws_security_group.database.id]
  publicly_accessible    = false

  # High availability - DISABLED for free tier
  multi_az = false

  # Backup configuration
  backup_retention_period = 7
  backup_window           = "03:00-04:00" # UTC
  maintenance_window      = "mon:04:00-mon:05:00"
  skip_final_snapshot     = false
  final_snapshot_identifier = "healthcare-fhir-db-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  # Parameter and option groups
  parameter_group_name = aws_db_parameter_group.fhir_postgres.name

  # Monitoring
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  monitoring_interval             = 60
  monitoring_role_arn             = aws_iam_role.rds_monitoring.arn

  # Deletion protection - ENABLED for production
  deletion_protection = true

  # Performance Insights - FREE for 7 days retention
  performance_insights_enabled    = true
  performance_insights_kms_key_id = aws_kms_key.healthcare.arn
  performance_insights_retention_period = 7

  # Auto minor version upgrades
  auto_minor_version_upgrade = true

  # Copy tags to snapshots
  copy_tags_to_snapshot = true

  tags = {
    Name        = "FHIR Database"
    Project     = "Healthcare-DR"
    Environment = "Production"
    Compliance  = "HIPAA"
    Backup      = "Required"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [final_snapshot_identifier]
  }
}

# IAM role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring" {
  name = "rds-enhanced-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name    = "RDS Enhanced Monitoring Role"
    Project = "Healthcare-DR"
  }
}

resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# CloudWatch Log Group for RDS logs
resource "aws_cloudwatch_log_group" "rds_postgresql" {
  name              = "/aws/rds/instance/healthcare-fhir-db/postgresql"
  retention_in_days = 7
  # Remove this line - CloudWatch Logs doesn't need KMS encryption for this use case
  # kms_key_id        = aws_kms_key.healthcare.arn

  tags = {
    Name    = "RDS PostgreSQL Logs"
    Project = "Healthcare-DR"
  }
}

# Outputs
output "rds_endpoint" {
  value       = aws_db_instance.fhir.endpoint
  description = "RDS PostgreSQL endpoint"
  sensitive   = true
}

output "rds_address" {
  value       = aws_db_instance.fhir.address
  description = "RDS PostgreSQL address"
  sensitive   = true
}

output "rds_port" {
  value       = aws_db_instance.fhir.port
  description = "RDS PostgreSQL port"
}

output "rds_database_name" {
  value       = aws_db_instance.fhir.db_name
  description = "RDS database name"
}

output "rds_secret_arn" {
  value       = aws_secretsmanager_secret.rds_credentials.arn
  description = "ARN of Secrets Manager secret containing RDS credentials"
}