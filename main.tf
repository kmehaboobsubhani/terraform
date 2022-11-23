terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}
# --------- VPC------- Done
# ------InternetGateway--Done
# ---------Subnet1--------Done
#---------Subnet2--------Done
# ------RoutingTable1-----
#------RoutingTable1-----

# --------- VPC----------
# Create a VPC in AWS part of region 
resource "aws_vpc" "mehaboob_vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name       = "mehaboob_vpc"
    Created_By = "Terraform"
  }
}

# ------InternetGateway-----
# Create a INTERNAT GATEWAY in AWS part of region 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.mehaboob_vpc.id

  tags = {
    Name = "main"
  }
}

# ---------Subnet1--------
# Create a Public-Subnet1 part of mehaboob_vpc 
resource "aws_subnet" "mehaboob_public_subnet1" {
  vpc_id                  = aws_vpc.mehaboob_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name       = "mehaboob_public_subnet1"
    created_by = "Terraform"
  }
}

# ---------Subnet2--------
# Create a Private-Subnet1 part of mehaboob_vpc 
resource "aws_subnet" "mehaboob_private_subnet1" {
  vpc_id            = aws_vpc.mehaboob_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name       = "mehaboob_private_subnet1"
    created_by = "Terraform"
  }
}

# ------RoutingTable1--------
resource "aws_route_table" "example1" {
  vpc_id = aws_vpc.mehaboob_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  #route {
  # ipv6_cidr_block        = "::/0"
  #  egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  #}

  tags = {
    Name = "example"
  }
}


# Outputs
output "vpc_id" {
  value = aws_vpc.mehaboob_vpc.id
}
output "internet_gateway_id" {
  value = aws_internet_gateway.gw.id
}
output "aws_route_table" {
  value = aws_route_table.example1.id
}

