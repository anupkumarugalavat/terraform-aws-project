# Provider Configuration
# ---------------------
# This file configures where Terraform connects and how it authenticates,
# serving as the foundation for provisioning any AWS resources.

# AWS Provider Configuration
# The AWS provider is responsible for interacting with the many AWS services
# through their respective APIs.
provider "aws" {
  region  = "ap-south-1"  # Mumbai region
  profile = "default"     # Uses the default AWS CLI profile for authentication
  
  # Additional optional configurations:
  # - access_key and secret_key can be specified here instead of using profile
  # - assume_role can be configured for cross-account management
  # - tags can be set as default tags for all resources
}

# Terraform Settings
# These settings configure Terraform's behavior and required providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"  # Source of the provider from the Terraform Registry
      version = "~> 4.0"         # Allows any 4.x version, but not 5.x or higher
    }
  }
  
  # Uncomment to configure remote state storage
  # backend "s3" {
  #   bucket = "my-terraform-state"
  #   key    = "prod/terraform.tfstate"
  #   region = "ap-south-1"
  # }
}

