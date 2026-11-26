# webApp = VPC + EC2   +   base de datos

# CAPA DE NETWORK =
        # |
#vpc_id          subnets
    # |            |
# CAPA DE           CAPA DE DATA
# COMPUTE


# capa 1
module "network" {
  source = "../modules/network"

  environment        = var.environment # variable del root → baja al módulo
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]
}
# capa 2
module "compute" {
  source = "../modules/compute"

  vpc_id         = module.network.vpc_id            # ← output de network
  subnet_ids     = module.network.public_subnet_ids # ← output de network
  app_name       = var.app_name
  environment    = var.environment
  instance_type  = "t3.small"
  instance_count = 2
}
# capa 3
module "data" {
  source = "../modules/data"

  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids # privadas, no públicas
  app_sg_id          = module.compute.app_sg_id          # ← output de compute
  app_name           = var.app_name
  app_url            = module.compute.app_url
  environment        = var.environment
}
