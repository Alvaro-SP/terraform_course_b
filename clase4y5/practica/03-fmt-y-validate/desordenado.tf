variable "proyecto" {
  type    = string
  default = "edutek"
}
variable "ambiente" {
  type    = string
  default = "dev"
}

locals {
  nombre = "${var.proyecto}-${var.ambiente}"
  tags = {
    Proyecto  = var.proyecto
    Ambiente  = var.ambiente
    ManagedBy = "Terraform"
  }
}
output "nombre" {
  value = local.nombre
}
output "tags" {
  value = local.tags
}
