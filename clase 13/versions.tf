terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # >= 5.0 y < 6.0 → acepta MINOR y PATCH, bloquea MAJOR
    }
  }
}
