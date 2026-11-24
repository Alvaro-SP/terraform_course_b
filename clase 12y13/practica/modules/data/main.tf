# CAPA DE DATOS
# SG de la base de datos + contrasenia aleatoria + secret
# recibe vpc_id + private subnet_ids , app_sg_id, app_name, env...

locals {
  db_identifier = "${var.app_name}-${var.environment}-postgres"

  # En AWS real esto sería aws_db_instance.this.address (lo da AWS).
  # Aquí lo armamos a mano porque LocalStack gratis no trae RDS.
  db_host = "${local.db_identifier}.internal"
  db_port = 5432
}
# 1 SG
resource "aws_security_group" "db" {
  name        = "${var.app_name}-${var.environment}-db-sg"
  description = "PostgreSQL solo desde la app"
  vpc_id      = var.vpc_id # ← de network

  ingress {
    description     = "PostgreSQL desde el SG de la app"
    from_port       = local.db_port
    to_port         = local.db_port
    protocol        = "tcp"
    security_groups = [var.app_sg_id] # ← de compute
  }

  tags = {
    Name = "${var.app_name}-${var.environment}-db-sg"
  }
}
# 2. contraseña generada
resource "random_password" "db" {
  length  = 20
  special = false
}
# 3. secret manager

resource "aws_secretsmanager_secret" "db" {
  name                    = "${var.app_name}/${var.environment}/db"
  recovery_window_in_days = 0 # para el curso: borrar sin esperar 7-30 días
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    engine   = "postgres"
    host     = local.db_host
    port     = local.db_port
    dbname   = var.db_name
    username = var.db_username
    password = random_password.db.result
  })
}
