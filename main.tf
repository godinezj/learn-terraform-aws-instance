terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "bastion" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"
  key_name      = "javier"
  subnet_id     = "subnet-a9d32fc2"
  root_block_device {
    encrypted = true
  }
  metadata_options {
    http_tokens = "required"
  }
  tags = {
    Name = "Bastion"
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"
  key_name      = "javier"
  subnet_id     = "subnet-00c81127c4cf2ac81"
  root_block_device {
    encrypted = true
  }
  metadata_options {
    http_tokens = "required"
  }
  tags = {
    Name = "appserver"
  }
}

