# ECS Task Definition for HAPI FHIR Server
# Free tier: Fargate 20GB-hours compute (0.25 vCPU = 80 hours/month)

# ECS Task Definition
resource "aws_ecs_task_definition" "fhir" {
  family                   = "healthcare-fhir-server"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"  # 512 vCPU
  memory                   = "1024"  # 1.0 GB
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task.arn

  container_definitions = jsonencode([
    {
      name      = "fhir-server"
      image     = "hapiproject/hapi:latest"
      essential = true

      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "spring.datasource.url"
          value = "jdbc:postgresql://${aws_db_instance.fhir.address}:${aws_db_instance.fhir.port}/${aws_db_instance.fhir.db_name}"
        },
        {
          name  = "spring.datasource.username"
          value = "fhiradmin"
        },
        {
          name  = "spring.datasource.driverClassName"
          value = "org.postgresql.Driver"
        },
        {
          name  = "spring.jpa.properties.hibernate.dialect"
          value = "ca.uhn.fhir.jpa.model.dialect.HapiFhirPostgres94Dialect"
        },
        {
          name  = "hapi.fhir.default_encoding"
          value = "json"
        },
        {
          name  = "hapi.fhir.server_address"
          value = "http://${aws_lb.fhir.dns_name}/fhir"
        },
        {
          name  = "hapi.fhir.allow_external_references"
          value = "true"
        },
        {
          name  = "hapi.fhir.allow_multiple_delete"
          value = "true"
        },
        {
          name  = "hapi.fhir.cors.enabled"
          value = "true"
        }
      ]

      secrets = [
        {
          name      = "spring.datasource.password"
          valueFrom = "${aws_secretsmanager_secret.rds_credentials.arn}:password::"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.fhir_app.name
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "fhir"
        }
      }

      # healthCheck = {
      #  command = [
      #    "CMD-SHELL",
      #    "curl -f http://localhost:8080/fhir/metadata || exit 1"
      #  ]
      #  interval    = 30
      #  timeout     = 5
      #  retries     = 3
      #  startPeriod = 60
      # }
    }
  ])

  tags = {
    Name    = "FHIR Server Task Definition"
    Project = "Healthcare-DR"
  }
}

# ECS Service
resource "aws_ecs_service" "fhir" {
  name            = "healthcare-fhir-service"
  cluster         = aws_ecs_cluster.fhir.id
  task_definition = aws_ecs_task_definition.fhir.arn
  desired_count   = 1
  launch_type     = "FARGATE"

    network_configuration {
    subnets          = [aws_subnet.public.id]  # Changed from private_app
    security_groups  = [aws_security_group.app.id]
    assign_public_ip = true  # Changed from false - needed to pull from Docker Hub
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.fhir.arn
    container_name   = "fhir-server"
    container_port   = 8080
  }

  health_check_grace_period_seconds = 300

  depends_on = [
    aws_lb_listener.fhir_http,
    aws_iam_role_policy.ecs_secrets_access
  ]

  tags = {
    Name    = "FHIR ECS Service"
    Project = "Healthcare-DR"
  }
}

# Outputs
output "ecs_service_name" {
  value       = aws_ecs_service.fhir.name
  description = "ECS service name"
}

output "fhir_task_definition_arn" {
  value       = aws_ecs_task_definition.fhir.arn
  description = "FHIR task definition ARN"
}