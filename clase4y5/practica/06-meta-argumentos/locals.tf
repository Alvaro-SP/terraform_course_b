# =====================================================================
# locals.tf: valores calculados que se reutilizan en todo el proyecto
# =====================================================================

locals {
  nombre_prefijo = "${var.proyecto}-${var.ambiente}" # mi-app-desarrollo

  etiquetas_estandar = {
    Proyecto  = var.proyecto
    Ambiente  = var.ambiente
    ManagedBy = "Terraform"
    Clase     = "Terraform-4y5"
  }
}
