# OUTPUTS EN CASCADA: el hijo expone → el padre RE-EXPONE → el root lo usa
#   hijo:  output "vpc_id" { value = aws_vpc.this.id }
#   padre: output "vpc_id" { value = module.network.vpc_id }   ← aquí
#   root:  module.app_staging.vpc_id
# Si este archivo está vacío, el root ve module.app_staging como un objeto
# SIN atributos → "This object does not have an attribute named ..."

output "vpc_id" {
  description = "VPC del stack (viene del hijo network)"
  value       = module.network.vpc_id
}

output "app_url" {
  description = "URL pública de la app (viene del hijo compute)"
  value       = module.compute.app_url
}

output "db_secret_arn" {
  description = "Secreto con credenciales (viene del hijo data)"
  value       = module.data.db_secret_arn
}
