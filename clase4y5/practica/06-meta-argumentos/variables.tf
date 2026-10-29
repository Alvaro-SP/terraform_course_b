
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