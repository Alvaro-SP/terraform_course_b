

locals {
  # interpolacion
  nombre_servidor = "web-${var.ambiente}"
  # condicional 
  tipo_instancia = var.ambiente == "prod" ? "t3.large" : "t3.micro"
  # lookup
  tipo_desde_map = lookup(var.tipos_instancia, var.ambiente, "t3.micro")
#   merge()
    tags = merge (
        {Proyecto = "edutek", ManagedBy = "Terraform"},
        {Ambiente = var.ambiente},
    )
    # Expresion for
    zonas_mayusculas = [for z in var.zonas : upper(z)]
    # split y el length
    partes_region = split("-", var.region)
}

output "nombre_servidor" {
  value = local.nombre_servidor
}

output "tipo_instancia" {
  value = local.tipo_instancia
}
output "tipo_desde_map" {
  value = local.tipo_desde_map
}
output "tags" {
  value = local.tags
}
output "zonas_mayusculas" {
  value = local.zonas_mayusculas
}
output "partes_region" {
  value = local.partes_region
}
output "cantidad_zonas" {
    value = length(var.zonas)
}
output "disco_principal_gb" {
    value = var.servidor.discos[1]
}