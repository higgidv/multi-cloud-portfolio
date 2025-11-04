# Application Load Balancer for FHIR Server
# Free tier: 750 hours/month, 15GB data processed

# Update App Security Group to allow traffic from ALB
# resource "aws_security_group_rule" "app_from_alb" {
#  type                     = "ingress"
#  description              = "Allow traffic from ALB"
#  from_port                = 8080
#  to_port                  = 8080
#  protocol                 = "tcp"
#  security_group_id        = aws_security_group.app.id
#  source_security_group_id = aws_security_group.alb.id
# }

# Application Load Balancer
resource "aws_lb" "fhir" {
  name               = "healthcare-fhir-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public.id, aws_subnet.public_az2.id]

  enable_deletion_protection = false
  enable_http2              = true
  idle_timeout              = 60

  tags = {
    Name        = "FHIR Application Load Balancer"
    Project     = "Healthcare-DR"
    Environment = "Production"
  }
}

# Target Group for FHIR containers
resource "aws_lb_target_group" "fhir" {
  name        = "healthcare-fhir-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    path                = "/fhir/metadata"
    matcher             = "200"
    protocol            = "HTTP"
  }

  deregistration_delay = 30

  tags = {
    Name    = "FHIR Target Group"
    Project = "Healthcare-DR"
  }
}

# ALB Listener - HTTP
resource "aws_lb_listener" "fhir_http" {
  load_balancer_arn = aws_lb.fhir.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fhir.arn
  }

  tags = {
    Name    = "FHIR ALB HTTP Listener"
    Project = "Healthcare-DR"
  }
}

# Outputs
output "alb_dns_name" {
  value       = aws_lb.fhir.dns_name
  description = "ALB DNS name for accessing FHIR server"
}

output "alb_zone_id" {
  value       = aws_lb.fhir.zone_id
  description = "ALB hosted zone ID"
}

output "fhir_endpoint" {
  value       = "http://${aws_lb.fhir.dns_name}/fhir"
  description = "FHIR server endpoint URL"
}