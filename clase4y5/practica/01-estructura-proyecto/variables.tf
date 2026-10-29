
variable "proyecto" {
  description = "Nombre del proyecto"
  type        = string
  default     = "edutek"
}

variable "ambiente" {
  description = "Ambiente de despliegue: dev, qa o prod"
  type        = string
  # Sin default: Terraform la pide al hacer plan/apply,
  # a menos que venga en terraform.tfvars o en -var="ambiente=dev"
}

variable "equipo" {
  description = "Integrantes del equipo"
  type        = list(string)
  default     = ["ana", "luis", "maria"]
}
