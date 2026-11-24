variable "environment" {
  description = "Entorno: dev, staging o prod. Se usa en los nombres."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment debe ser dev, staging o prod."
  }
}

variable "cidr_block" {
  description = "Rango de IPs de la VPC (ej. 10.0.0.0/16)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Zonas donde crear subnets. Una pública y una privada por zona."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
