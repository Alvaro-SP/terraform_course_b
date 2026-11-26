
variable "environment" {
  description = "dev, staging o prod. El padre decide CIDR y tamaño según esto."
  type        = string
}

variable "app_name" {
  description = "Nombre corto de la app"
  type        = string
}
