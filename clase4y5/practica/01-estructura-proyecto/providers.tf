# CLASE 4 y 5
# Que provider usamos: local (archivos en tu PC), no AWS
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.9.1"
    }
  }
}

provider "local" {}
