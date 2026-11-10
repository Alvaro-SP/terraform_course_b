
locals {
  prefijo = "edutek-${var.environment}" # edutek-dev

  tags = {
    Proyecto  = "edutek-clase9"
    Ambiente  = var.environment
    ManagedBy = "Terraform"
  }

  usuarios = {
    for u in var.users : u.name => u
    if u.active
  }

  # Grupos sin repetir: dos personas de "backend" → un solo grupo.
  grupos = toset([for u in values(local.usuarios) : u.group])
}
