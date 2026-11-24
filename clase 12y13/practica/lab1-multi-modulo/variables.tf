
variable "aws_region" {
  description = "Región de AWS (LocalStack acepta cualquiera)"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno que estamos desplegando"
  type        = string
  default     = "dev"
}

variable "app_name" {
  description = "Nombre corto de la app"
  type        = string
  default     = "webapp"
}
