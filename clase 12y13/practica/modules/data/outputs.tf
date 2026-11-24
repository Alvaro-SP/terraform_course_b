
output "db_sg_id" {
  description = "SG de la base de datos"
  value       = aws_security_group.db.id
}

output "db_endpoint" {
  description = "host:puerto de la base (en AWS real: aws_db_instance.this.endpoint)"
  value       = "${local.db_host}:${local.db_port}"
}

output "db_secret_arn" {
  description = "ARN del secreto con las credenciales: esto es lo que se le pasa a la app"
  value       = aws_secretsmanager_secret.db.arn
}

output "db_password" {
  description = "Contraseña de la base"
  value       = random_password.db.result
  sensitive   = true
}
