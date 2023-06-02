terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

/*
  cloud {
    organization = "yesuac-llc"

    workspaces {
      name = "learn-terraform-aws-instance"
    }
  }
  */
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
  
}

resource "aws_vpc" "main" {
  cidr_block = var.vpcCIDRblock

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnetCIDRblock

  tags = {
    Name = "tf-subnet"
  }
}

resource "aws_instance" "app_server" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.vpc_security_group.id]
  subnet_id              = aws_subnet.main.id

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "vpc_security_group" {
  vpc_id      = aws_vpc.main.id
  name        = "My VPC Security Group"
  description = "My VPC Security Group"

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tf-sg"
  }
}



