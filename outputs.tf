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

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "web_server_public_ip" {
  description = "Public IP of the EC2 web server"
  value       = aws_instance.web_server.public_ip
}

output "web_server_public_dns" {
  description = "Public DNS of the EC2 web server"
  value       = aws_instance.web_server.public_dns
}