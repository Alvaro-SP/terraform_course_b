
locals {
  environment = "dev"
}

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../network/terraform.tfstate"
  }
}
module "compute" {
  source = "git::file:///C:/tf-modules/edutek-modules//compute?ref=v1.0.0"
  vpc_id     = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.network.outputs.public_subnet_ids

  app_name       = "webapp"
  environment    = local.environment
  instance_type  = "t3.small"
  instance_count = 2
}
