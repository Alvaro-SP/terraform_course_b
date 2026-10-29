# CLASE 3
# Que provider usamos y como se conecta a AWS
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "edutek-clase3"
      Environment = "lab"
      ManagedBy   = "Terraform"
    }
  }
}