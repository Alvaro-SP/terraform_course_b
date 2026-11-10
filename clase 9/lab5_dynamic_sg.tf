# =====================================================================
# LAB 5 · dynamic: loops DENTRO de un recurso (diapositiva 19)
# ---------------------------------------------------------------------
# count y for_each repiten RECURSOS completos. dynamic repite BLOQUES
# anidados, como ingress. Este security group lo usan las EC2 del Lab 1.
# =====================================================================

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "web" {
  name        = "${local.prefijo}-web-sg"
  description = "Reglas de entrada generadas desde var.allowed_ports"
  vpc_id      = data.aws_vpc.default.id

  # Genera un bloque ingress por cada puerto de la lista.
  # La variable del loop se llama como el bloque: ingress.value
  dynamic "ingress" {
    for_each = var.allowed_ports

    content {
      description = "Puerto ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Terraform borra la regla de salida que AWS crea por defecto.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, { Name = "${local.prefijo}-web-sg", Lab = "5-dynamic" })
}
