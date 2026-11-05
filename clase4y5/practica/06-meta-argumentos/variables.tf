
variable "proyecto" {
  description = "Nombre del proyecto"
  type        = string
  default     = "mi-app"

  # validation: Terraform rechaza el valor ANTES de crear nada
  validation {
    condition     = length(var.proyecto) > 3
    error_message = "El nombre del proyecto debe tener más de 3 caracteres."
  }
}
variable "ambiente" {
  description = "Ambiente de despliegue: desarrollo, testing o produccion"
  type        = string
}
variable "crear_bucket_principal" {
  description = "Crear o no el bucket principal"
  type        = bool
  default     = true
}

variable "cantidad_buckets" {
  description = "Cuantos buckets crear con count"
  type        = number
  default     = 3
  validation {
    condition     = var.cantidad_buckets > 0 && var.cantidad_buckets <= 10
    error_message = "La cantidad debe estar entre 1 y 10"
  }
}

variable "buckets_por_ambiente" {
  description = "un bucket por cada clave del map"
  type        = map(string)
  default = {
    desarrollo = "app-dev-bucket"
    testing    = "app-test-bucket"
    produccion = "app-prod-bucket"
  }
}

variable "habilitar_versioning" {
  description = "Habilitar versionamiento en los buckets de count"
  type        = bool
  default     = true
}

variable "crear_recursos_adicionales" {
  description = "Crear el bucket condicional"
  type        = bool
  default     = true
}

# ---- para la comparación count vs for_each
variable "equipos" {
  description = "Equipos que necesitan su propio bucket"
  type        = list(string)
  default     = ["frontend", "backend", "datos"]
}
