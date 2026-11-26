# --- Lo que viene de la capa NETWORK ---------------------------------
variable "vpc_id" {
  description = "VPC donde vive la base de datos"
  type        = string
}

variable "private_subnet_ids" {
  description = "Subnets PRIVADAS: una base de datos nunca va en subnet pública"
  type        = list(string)
}

# --- Lo que viene de la capa COMPUTE ---------------------------------
variable "app_sg_id" {
  description = "SG de la app: el único autorizado a entrar al 5432"
  type        = string
}

# --- Lo propio de la base de datos -----------------------------------
variable "app_name" {
  description = "Nombre corto de la app"
  type        = string
}

variable "environment" {
  description = "dev, staging o prod"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Usuario administrador de la base"
  type        = string
  default     = "appadmin"
}

variable "app_url" {
  description = "Url de la aplicacion generada en compute"
  type = string
}