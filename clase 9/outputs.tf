
# ---- Lab 1
output "web_names" {
  description = "Nombres de las instancias web (count)"
  value       = aws_instance.web[*].tags.Name
}

output "web_ids" {
  description = "IDs de las instancias web (count + splat)"
  value       = aws_instance.web[*].id
}

# ---- Lab 2
output "backup_bucket" {
  description = "Bucket de respaldo, si el interruptor está encendido"
  value       = try(aws_s3_bucket.backup[0].bucket, "No creado")
}

output "area_buckets" {
  description = "Buckets por área (for_each con set)"
  value       = { for area, b in aws_s3_bucket.area : area => b.bucket }
}

output "config_buckets" {
  description = "Buckets con configuración propia (for_each con map)"
  value       = { for nombre, b in aws_s3_bucket.this : nombre => b.bucket }
}

# ---- Lab 3
output "iam_users" {
  description = "Usuarios IAM creados (solo los activos)"
  value       = { for nombre, u in aws_iam_user.team : nombre => u.name }
}

output "iam_groups" {
  description = "Grupos IAM sin repetir"
  value       = sort(local.grupos)
}

# ---- Lab 4
output "upper_names" {
  description = "Lista → lista"
  value       = local.upper_names
}

output "hostnames" {
  description = "Lista → map"
  value       = local.hostnames
}

output "prod" {
  description = "Filtro con if"
  value       = local.prod
}

output "retencion" {
  description = "Map → map"
  value       = local.retencion
}

# ---- Lab 5
output "ingress_ports" {
  description = "Puertos abiertos en el security group (dynamic)"
  value       = [for regla in aws_security_group.web.ingress : regla.from_port]
}
