variable "aws_region" {
  description = "Región de AWS donde se crean los recursos"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre corto del proyecto. Se usa como prefijo de los buckets"
  type        = string
}

variable "environment" {
  description = "Entorno del proyecto (dev, staging o prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El environment debe ser dev, staging o prod."
  }
}
