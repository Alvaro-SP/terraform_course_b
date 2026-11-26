
variable "aws_region" {
  description = "Región de AWS (en LocalStack da igual, pero se respeta)."
  type        = string
  default     = "us-east-1"
}

variable "proyecto" {
  description = "Prefijo de nombres. Corto, minúsculas, sin espacios."
  type        = string
  default     = "edutek-c13"
}

variable "entorno" {
  description = "Entorno lógico (dev, staging, prod)."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.entorno)
    error_message = "entorno debe ser dev, staging o prod."
  }
}

variable "vpc_cidr" {
  description = "Rango de IPs de la VPC creada con el módulo OFICIAL."
  type        = string
  default     = "10.0.0.0/16"
}
variable "habilitar_nat" {
  description = "Si es true, el módulo VPC crea un NAT Gateway (uno solo, para ahorrar)."
  type        = bool
  default     = false
}