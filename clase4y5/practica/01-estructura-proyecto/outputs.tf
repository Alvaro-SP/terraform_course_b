
output "archivo_generado" {
  description = "Ruta del archivo que creó Terraform"
  value       = local_file.readme.filename
}

output "nombre_prefijo" {
  description = "Prefijo calculado en locals.tf"
  value       = local.nombre_prefijo
}
