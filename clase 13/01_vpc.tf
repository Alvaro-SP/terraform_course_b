
# modulo = https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

data "aws_availability_zones" "disponibles" {
  state = "available"
}

locals {
  nombre = "${var.proyecto}-${var.entorno}" # → "edutek-c13-dev"

  # Las 2 primeras AZ de la región (us-east-1a, us-east-1b).
  azs = slice(data.aws_availability_zones.disponibles.names, 0, 2)
}

module "vpc" {
    # source = "NAMESPACE / NOMBRE / PROVIDER"
    # Terraform-aws-modules -> quien lo publica
    # vpc -> nombre del modulo
    # aws -> provider
    source = "terraform-aws-modules/vpc/aws"
    version = "~> 5.0"

    # ---------- INPUTS ---------------
    name = local.nombre
    cidr = var.vpc_cidr
    azs = local.azs
    # una subred publica y una privada por AZ
    public_subnets =  ["10.0.101.0/24", "10.0.102.0/24"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    map_public_ip_on_launch = true
    enable_dns_hostnames = true
    enable_dns_support   = true

    enable_nat_gateway = var.habilitar_nat
    single_nat_gateway = true

    # Tags para todo lo que crea el módulo (se suman a default_tags).
    tags = {
        Entorno = var.entorno
        Modulo  = "terraform-aws-modules/vpc"
    }
}