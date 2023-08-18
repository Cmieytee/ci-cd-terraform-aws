terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    key = "aws/ec2-deploy/terraform.tfstate"
  }
}

provider "aws" {
  region = var.region
}

resource "aws_iam_instance_profile" "ec2-profile" {
  name = "ec2-profile"
  role = "EC2-ECR-auth"
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_security_group" "main_sg" {
  name        = "terraform-main"
  description = "Security group using Terraform"
  vpc_id      = "vpc-0e6c44411c7e5483a"

  # Ingress and egress rules...

  tags = {
    Name = "TF_main"
  }
}

resource "aws_instance" "ubuntu-instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2-profile.name
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = var.private_key
    timeout     = "4m"
  }
  
  tags = {
    "name" = "DeployVM"
  }
}

output "instance_public_ip" {
  value     = aws_instance.ubuntu-instance.public_ip
  sensitive = true
}



