
# --- Lo que viene de la capa NETWORK ---------------------------------
variable "vpc_id" {
  description = "VPC donde se despliega la app (sale de module.network.vpc_id)"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets donde repartir las EC2 (normalmente las públicas)"
  type        = list(string)
}

# --- Lo propio de la aplicación ---------------------------------------
variable "app_name" {
  description = "Nombre corto de la app. Se usa en los nombres de recursos."
  type        = string
}

variable "environment" {
  description = "dev, staging o prod"
  type        = string
}

variable "instance_type" {
  description = "Tamaño de las EC2"
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "Cuántos servidores web crear"
  type        = number
  default     = 2
}

variable "ami_id" {
  description = "Imagen de las EC2. El default es una AMI de prueba de LocalStack; en AWS real se busca con data \"aws_ami\"."
  type        = string
  default     = "ami-ff0fea8310f3"
}

# --- Opcional: usado SOLO para provocar el ciclo del Lab 3 ------------
variable "db_sg_ids" {
  description = "SG de la base de datos a los que se permite salir por 5432. Vacío = ninguno."
  type        = list(string)
  default     = []
}
