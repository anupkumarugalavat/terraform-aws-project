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
  description = "The AWS region to deploy resources into (e.g., us-east-1, eu-west-1, ap-south-1)"
  type        = string
  default     = "ap-south-1"  # Default region if none is specified
}

variable "instance_type" {
  description = "The EC2 instance type to use for compute resources (e.g., t2.micro, m5.large)"
  type        = string
  default     = "t2.micro"  # Default to free tier eligible instance type
}

