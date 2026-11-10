
variable "aws_region" {
  description = "Región donde se despliega el proyecto"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente; forma parte del nombre de los recursos"
  type        = string
  default     = "dev"
}

# ---------------------------------------------------------------- LAB 1 · count
variable "instance_count" {
  description = "Cuántas instancias web idénticas crear con count"
  type        = number
  default     = 5
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

# Esta LISTA existe solo para demostrar el talón de Aquiles de count.
variable "workers" {
  description = "Workers con identidad propia (se crean con count Y con for_each para comparar)"
  type        = list(string)
  default     = ["api", "batch", "cron"]
}

# ---------------------------------------------------------------- LAB 2 · for_each
# Sirve de interruptor: count = var.create_backup ? 1 : 0
variable "create_backup" {
  description = "Crear o no el bucket de respaldo"
  type        = bool
  default     = true
}

# for_each con SET: solo necesitamos nombres únicos.
variable "areas" {
  description = "Áreas de la empresa; cada una recibe un bucket"
  type        = list(string)
  default     = ["ventas", "soporte", "finanzas"]
}

# for_each con MAP: cada bucket trae su propia configuración.
variable "buckets" {
  description = "Buckets con configuración distinta por clave"
  type = map(object({
    versioning = bool
    days       = number
  }))

  default = {
    logs    = { versioning = false, days = 30 }
    backups = { versioning = true, days = 365 }
    media   = { versioning = true, days = 90 }
  }
}

# ---------------------------------------------------------------- LAB 3 · IAM
# Viene como LISTA de objetos (como llegaría de un sistema de RRHH).
# En locals.tf se convierte en un map por nombre para usar for_each.
variable "users" {
  description = "Personas del equipo; active = false significa que no tiene usuario"
  type = list(object({
    name   = string
    role   = string
    group  = string
    active = bool
  }))

  default = [
    { name = "alvaro", role = "admin", group = "ops", active = true },
    { name = "ana", role = "dev", group = "backend", active = true },
    { name = "carlos", role = "viewer", group = "qa", active = true },
    { name = "diana", role = "dev", group = "backend", active = false },
  ]
}

# ---------------------------------------------------------------- LAB 4 · for
variable "names" {
  description = "Lista simple para transformar con expresiones for"
  type        = list(string)
  default     = ["alvaro", "ana", "carlos"]
}

variable "envs" {
  description = "Lista de entornos para demostrar el filtro if"
  type = list(object({
    name = string
    tier = string
  }))

  default = [
    { name = "dev", tier = "non-prod" },
    { name = "qa", tier = "non-prod" },
    { name = "prod", tier = "prod" },
  ]
}

# ---------------------------------------------------------------- LAB 5 · dynamic
variable "allowed_ports" {
  description = "Puertos de entrada; cada uno genera un bloque ingress"
  type        = list(number)
  default     = [22, 80, 443]
}
