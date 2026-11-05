output "nombre_prefijo" {
  description = "Prefijo calculado en locals.tf"
  value       = local.nombre_prefijo
}

# Recurso condicional (count 0 o 1): try() evita el error si no existe
output "bucket_principal" {
  description = "Nombre del bucket principal, si se creó"
  value       = try(aws_s3_bucket.bucket_principal[0].bucket, "No creado")
}

# count → lista. [*] (splat) saca un atributo de todos los elementos
output "buckets_count" {
  description = "Buckets creados con count"
  value       = aws_s3_bucket.buckets_con_count[*].bucket
}

output "buckets_count_total" {
  description = "Cuántos buckets se crearon con count"
  value       = length(aws_s3_bucket.buckets_con_count)
}

# for_each → map. Con una expresión for lo convertimos en clave => nombre
output "buckets_foreach" {
  description = "Buckets creados con for_each (clave => nombre)"
  value       = { for clave, b in aws_s3_bucket.buckets_con_foreach : clave => b.bucket }
}

output "bucket_testing" {
  description = "Acceso directo por clave a un recurso de for_each"
  value       = aws_s3_bucket.buckets_con_foreach["testing"].bucket
}
