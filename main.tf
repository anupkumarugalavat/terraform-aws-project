/*
  main.tf - Primary Resource Configuration File

  This file contains the primary infrastructure resources for the project.
  In Terraform projects, main.tf typically defines the core resources that
  make up your infrastructure, showing how they relate to each other.

  While you can organize resources across multiple .tf files, the main.tf
  file conventionally contains the most important resources and their
  relationships, serving as the central blueprint of your infrastructure.
*/

# ---------------------------------------------------------------------------------------------------------------------
# VPC CONFIGURATION
# Creates a Virtual Private Cloud to isolate our resources in AWS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "main-vpc"
    Environment = "demo"
    Terraform   = "true"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# SUBNET CONFIGURATION
# Creates public and private subnets across two availability zones for high availability
# ---------------------------------------------------------------------------------------------------------------------

# Public subnet in the first availability zone
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-subnet-1"
    Environment = "demo"
    Terraform   = "true"
  }
}

# Public subnet in the second availability zone
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-subnet-2"
    Environment = "demo"
    Terraform   = "true"
  }
}

# Private subnet in the first availability zone
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name        = "private-subnet-1"
    Environment = "demo"
    Terraform   = "true"
  }
}

# Private subnet in the second availability zone
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "private-subnet-2"
    Environment = "demo"
    Terraform   = "true"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# INTERNET GATEWAY
# Allows communication between VPC instances and the internet
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "main-igw"
    Environment = "demo"
    Terraform   = "true"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# ROUTE TABLES AND ASSOCIATIONS
# Defines how traffic is directed within the VPC
# ---------------------------------------------------------------------------------------------------------------------

# Public route table - allows traffic to/from internet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "public-route-table"
    Environment = "demo"
    Terraform   = "true"
  }
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

# ---------------------------------------------------------------------------------------------------------------------
# SECURITY GROUP
# Acts as a virtual firewall for the EC2 instance
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow inbound SSH and HTTP traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "ec2-security-group"
    Environment = "demo"
    Terraform   = "true"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# EC2 INSTANCE
# Deploys a virtual server running in the public subnet
# References the input variables aws_region and instance_type to customize the deployment
# ---------------------------------------------------------------------------------------------------------------------

# Look up the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 instance definition
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type  # Uses the instance_type variable
  subnet_id              = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = "sree-terraform"  # Note: you need to create this key pair in AWS first

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Hello from Nginx in ${var.aws_region}!</h1>" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name        = "web-server"
    Environment = "demo"
    Terraform   = "true"
  }

  # This resource explicitly depends on the Internet Gateway
  # to ensure it has internet connectivity when it's created
  depends_on = [aws_internet_gateway.main]
}

