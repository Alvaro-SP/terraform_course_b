output "db_endpoint" {
  value = module.data.db_endpoint
}

output "db_secret_arn" {
  value = module.data.db_secret_arn
}

output "db_password" {
  value     = module.data.db_password
  sensitive = true
}
