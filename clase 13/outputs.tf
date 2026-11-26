
# module.NOMBRE_DEL_BLOQUE.OUTPUT_DEL_MODULO

output "vpc_id" {
  description = "ID de la VPC creada por el módulo oficial."
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR de la VPC."
  value       = module.vpc.vpc_cidr_block
}

output "azs" {
  description = "Zonas de disponibilidad usadas."
  value       = module.vpc.azs
}

output "subredes_publicas" {
  description = "IDs de las subredes públicas (lista)."
  value       = module.vpc.public_subnets
}

output "subredes_privadas" {
  description = "IDs de las subredes privadas (lista)."
  value       = module.vpc.private_subnets
}

output "nat_gateway_ips" {
  description = "IPs públicas de los NAT (lista vacía si habilitar_nat = false)."
  value       = module.vpc.nat_public_ips
}
