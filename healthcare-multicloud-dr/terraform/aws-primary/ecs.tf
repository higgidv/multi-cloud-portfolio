# ECS Cluster for FHIR Server
# Free tier: Fargate 20GB-hours compute, 10GB storage

# ECS Cluster
resource "aws_ecs_cluster" "fhir" {
  name = "healthcare-fhir-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "FHIR ECS Cluster"
    Project     = "Healthcare-DR"
    Environment = "Production"
  }
}

# CloudWatch Log Group for ECS tasks
resource "aws_cloudwatch_log_group" "fhir_app" {
  name              = "/ecs/healthcare-fhir-server"
  retention_in_days = 7

  tags = {
    Name    = "FHIR Application Logs"
    Project = "Healthcare-DR"
  }
}

# IAM Role for ECS Task Execution (pulls images, writes logs)
resource "aws_iam_role" "ecs_task_execution" {
  name = "healthcare-fhir-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name    = "ECS Task Execution Role"
    Project = "Healthcare-DR"
  }
}

# Attach AWS managed policy for ECS task execution
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Custom policy for Secrets Manager access
resource "aws_iam_role_policy" "ecs_secrets_access" {
  name = "ecs-secrets-manager-access"
  role = aws_iam_role.ecs_task_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = aws_secretsmanager_secret.rds_credentials.arn
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = aws_kms_key.healthcare.arn
      }
    ]
  })
}

# IAM Role for ECS Task (application runtime permissions)
resource "aws_iam_role" "ecs_task" {
  name = "healthcare-fhir-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name    = "ECS Task Role"
    Project = "Healthcare-DR"
  }
}

# Policy for task to access RDS (network connectivity verified via security groups)
resource "aws_iam_role_policy" "ecs_task_rds_access" {
  name = "ecs-task-rds-access"
  role = aws_iam_role.ecs_task.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "rds:DescribeDBInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

# Outputs
output "ecs_cluster_name" {
  value       = aws_ecs_cluster.fhir.name
  description = "ECS cluster name"
}

output "ecs_cluster_arn" {
  value       = aws_ecs_cluster.fhir.arn
  description = "ECS cluster ARN"
}