# Terraform Variable Values (.tfvars) File
#
# This file contains the actual values for variables defined in variables.tf.
# It allows you to set default values that can be used when running Terraform commands
# without having to specify them on the command line each time.
#
# These values can be overridden by:
# 1. Command line flags: terraform apply -var="aws_region=us-east-1"
# 2. Environment variables: export TF_VAR_aws_region=us-east-1
# 3. Other .tfvars files specified with -var-file flag
#
# Using this file makes it easy to manage different environments or deployment configurations.

# AWS region where resources will be deployed
aws_region = "ap-south-1"

# Type of EC2 instance to be used
instance_type = "t2.micro"

# You can add more variable values here as needed for your infrastructure

