# Terraform AWS Nginx Deployment

This project demonstrates how to use Terraform to deploy a complete AWS infrastructure including a VPC, subnets, Internet Gateway, security groups, and an EC2 instance running Nginx.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) (v1.0+)
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS EC2 key pair named "sree-terraform" (or update the key_name in main.tf)

## Project Structure

- `provider.tf`: AWS provider configuration
- `variables.tf`: Input variables definition
- `terraform.tfvars`: Variable values
- `main.tf`: Main infrastructure definition
- `outputs.tf`: Output values

## Infrastructure Components

- VPC with CIDR 10.0.0.0/16
- 2 Public Subnets in different Availability Zones
- 2 Private Subnets in different Availability Zones
- Internet Gateway
- Route Table for public subnets
- Security Group allowing SSH (port 22) and HTTP (port 80)
- EC2 instance running Nginx

## Step-by-Step Deployment Guide

### 1. Clone the repository

```bash
git clone https://github.com/your-username/terraform-aws-nginx.git
cd terraform-aws-nginx
```

### 2. Update the terraform.tfvars file (optional)

Edit the `terraform.tfvars` file to customize the deployment parameters such as AWS region, instance type, etc.

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Preview the changes

```bash
terraform plan
```

### 5. Deploy the infrastructure

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment, or use `terraform apply --auto-approve` to skip the confirmation.

### 6. Access the Nginx web server

After the deployment completes, Terraform will output the public IP address and DNS name of the EC2 instance. You can access the Nginx web server by opening the IP address in your web browser:

```
http://<ec2_instance_public_ip>
```

### 7. Clean up

When you're done using the resources, you can destroy them to avoid incurring charges:

```bash
terraform destroy
```

Type `yes` when prompted to confirm the destruction.

## Customization

You can customize this deployment by:

- Modifying the CIDR blocks for the VPC and subnets in `main.tf`
- Changing the instance type or AMI in `variables.tf` and `terraform.tfvars`
- Adding or modifying security group rules in `main.tf`
- Customizing the Nginx installation in the user_data script in `main.tf`

## Security Considerations

This setup is designed for demonstration purposes. For production use, consider:

- Restricting SSH access to specific IP addresses rather than 0.0.0.0/0
- Setting up proper IAM roles and policies
- Implementing private subnets with NAT gateways for better security
- Using HTTPS instead of HTTP
- Implementing additional security measures like a Web Application Firewall (WAF)

## License

[MIT License](LICENSE)

