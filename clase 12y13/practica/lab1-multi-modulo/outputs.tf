output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "instance_ids" {
  value = module.compute.instance_ids
}

output "app_url" {
  description = "Entregable del Lab 1: debe responder HTTP 200"
  value       = module.compute.app_url
}

output "db_endpoint" {
  value = module.data.db_endpoint
}

output "db_secret_arn" {
  value = module.data.db_secret_arn
}

# Un output que viene de un output sensitive TAMBIÉN debe ser sensitive,
# si no Terraform da error. La "sensibilidad" se hereda hacia arriba.
output "db_password" {
  value     = module.data.db_password
  sensitive = true
}
