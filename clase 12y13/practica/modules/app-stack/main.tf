

locals {
  # Decisión que toma el PADRE para que el consumidor no tenga que saberla:
  # cada entorno tiene su propio rango de IPs (así nunca se solapan).
  cidr_por_entorno = {
    dev     = "10.10.0.0/16"
    staging = "10.20.0.0/16"
    prod    = "10.30.0.0/16"
  }

  # En prod, 3 servidores; en el resto, 1 (más barato).
  instancias = var.environment == "prod" ? 3 : 1
}

# HIJO 1 RED
module "network" {
  source = "../network"

  environment = var.environment                         # el padre PROPAGA la variable
  cidr_block  = local.cidr_por_entorno[var.environment] # y DECIDE el CIDR
}

# HIJO 2 COMPUTE
module "compute" {
  source = "../compute"

  vpc_id         = module.network.vpc_id
  subnet_ids     = module.network.public_subnet_ids
  app_name       = var.app_name
  environment    = var.environment
  instance_count = local.instancias
}

# hijo 3 data
module "data" {
  source = "../data"

  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  app_sg_id          = module.compute.app_sg_id
  app_name           = var.app_name
  app_url = module.compute.app_url
  environment        = var.environment
}
