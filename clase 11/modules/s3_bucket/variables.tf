variable "bucket_name" {
  description = "Nombre único (global) del bucket S3"
  type        = string
}

variable "environment" {
  description = "Entorno donde se usa el bucket (dev, staging o prod)"
  type        = string
  default     = "dev"

  # validation: el módulo se defiende solo de valores inválidos,
  # sin importar quién lo llame.
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El environment debe ser dev, staging o prod."
  }
}
variable "owner" {
    description = "Owner del proyecto"
    type = string
    default = "Edutek-latam"
}