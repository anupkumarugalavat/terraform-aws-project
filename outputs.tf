# --------------------------------------------------------
# Terraform Outputs Configuration
# --------------------------------------------------------
# This file defines output values that Terraform will display after
# applying the configuration. Outputs provide a way to extract and
# expose important information about the resources created.
#
# Outputs serve several important purposes:
# 1. They provide visibility into key resource attributes
# 2. They enable integration with other systems or processes
# 3. They can be used as inputs for other Terraform configurations
# 4. They document important endpoints and values for team members

# EC2 Instance Outputs
output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "ec2_instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "ec2_instance_public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}

# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

# Subnet Outputs
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

# Security Group Outputs
output "app_server_security_group_id" {
  description = "The ID of the security group attached to the app server"
  value       = aws_security_group.ec2_sg.id
}

# Internet Gateway Output
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

# Route Table Outputs
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}

# --------------------------------------------------------
# Notes on Output Usage:
# --------------------------------------------------------
# These outputs enhance visibility in several ways:
#
# 1. For Operators: Access important endpoints without logging into AWS console
#    Example: Use `terraform output ec2_instance_public_ip` to get the server IP
#
# 2. For Integration: Outputs can be consumed by other tools or scripts
#    Example: CI/CD pipelines can read these values for deployment tasks
#
# 3. For Documentation: Self-documenting infrastructure with critical values
#    Example: New team members can quickly understand the infrastructure layout
#
# 4. For Debugging: Quickly verify resource creation and configurations
#    Example: Confirm subnet associations by examining the output values

