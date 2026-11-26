
module "app_staging" {
  source = "../modules/app-stack"

  environment = "staging"
  app_name    = "webapp"
}

# El root solo ve lo que el PADRE re-expone (vpc_id, app_url, db_secret_arn).
# module.app_staging.private_subnet_ids daría "Unsupported attribute".
output "staging_app_url" {
  value = module.app_staging.app_url
}

output "staging_vpc_id" {
  value = module.app_staging.vpc_id
}
