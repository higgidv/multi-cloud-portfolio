# outputs.tf
# Output values for AWS Primary Infrastructure

###############################################################################
# Account Information
###############################################################################

output "account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}

###############################################################################
# VPC Outputs
###############################################################################

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

###############################################################################
# Subnet Outputs
###############################################################################

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_app_subnet_id" {
  description = "ID of the private application subnet"
  value       = aws_subnet.private_app.id
}

output "private_data_subnet_id" {
  description = "ID of the private data subnet"
  value       = aws_subnet.private_data.id
}

###############################################################################
# Security Group Outputs
###############################################################################

output "alb_security_group_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "app_security_group_id" {
  description = "ID of the application security group"
  value       = aws_security_group.app.id
}

output "database_security_group_id" {
  description = "ID of the database security group"
  value       = aws_security_group.database.id
}

###############################################################################
# S3 Bucket Outputs
###############################################################################

output "cloudtrail_bucket" {
  description = "Name of the CloudTrail S3 bucket"
  value       = aws_s3_bucket.cloudtrail.id
}