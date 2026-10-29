
locals {
    nombre_prefijo = "${var.proyecto}-${var.ambiente}"

    integrantes = join(", ", var.equipo)
}