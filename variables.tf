# ---------------------------------------------------------------------------------------------------------------------
# TERRAFORM VARIABLES
# ---------------------------------------------------------------------------------------------------------------------
# This file defines input variables that can be used throughout the Terraform configuration.
# Variables allow you to parameterize your infrastructure, making it easy to customize values
# for different environments (dev, staging, production) without modifying the core code.
# You can override these default values by:
# 1. Setting environment variables (TF_VAR_variable_name)
# 2. Using a .tfvars file
# 3. Passing variables directly on the command line (-var "variable_name=value")

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key name for EC2 instance"
  type        = string
  default     = "terraform_key"
}