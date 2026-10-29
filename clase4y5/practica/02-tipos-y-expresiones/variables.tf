
# PRIMITIVOS\
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cantidad_servidores" {
  type    = number
  default = 3
}

variable "habilitar_backups" {
  type    = bool
  default = true
}

# COLECCIONES
# list por indice -> var.zonas[0]
variable "zonas" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
# map:  -> var.tipos_instancia["prod"]
variable "tipos_instancia" {
  type = map(string)
  default = {
    dev  = "t3.micro"
    qa   = "t3.small"
    prod = "t3.large"
  }
}
# set (es como un list sin duplicados y sin orden) no admite [0]
variable "puertos" {
  type    = set(number)
  default = [80, 443, 80]
}

# ESTRUCTURALES
# Object
variable "servidor" {
  type = object({
    nombre = string
    cpu    = number
    public = bool
    discos = list(number)
  })
  default = {
    nombre = "web-01"
    cpu    = 2
    public = true
    discos = [20, 100]
  }
}
# tupla
variable "registro" {
  type    = tuple([string, number, bool])
  default = ["backup-diario", 7, true]
}

variable "ambiente" {
  type    = string
  default = "dev"
}