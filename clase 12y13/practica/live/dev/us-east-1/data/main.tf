
locals {
  environment = "dev"
}

data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../network/terraform.tfstate"
  }
}

data "terraform_remote_state" "compute" {
  backend = "local"
  config = {
    path = "../compute/terraform.tfstate"
  }
}

module "data" {
  source = "git::file:///C:/tf-modules/edutek-modules//data?ref=v1.0.0"

  vpc_id             = data.terraform_remote_state.network.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  app_sg_id          = data.terraform_remote_state.compute.outputs.app_sg_id

  app_name    = "webapp"
  environment = local.environment
}
