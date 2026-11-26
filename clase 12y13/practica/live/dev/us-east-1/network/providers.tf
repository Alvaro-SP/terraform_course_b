
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # State LOCAL en esta carpeta (terraform.tfstate).
  # En una empresa: backend "s3" con key = "dev/us-east-1/network.tfstate"
  # (ver Clase 10).
}

provider "aws" {
  region = "us-east-1" # ← la región está en el nombre de la carpeta

  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    ec2            = "http://localhost:4566"
    s3             = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }

  # Mismas etiquetas que el Lab 1 → tras migrar, el plan da 'No changes'.
  default_tags {
    tags = {
      Proyecto  = "edutek-clase12"
      ManagedBy = "terraform"
    }
  }
}
