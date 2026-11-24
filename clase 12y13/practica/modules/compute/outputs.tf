output "app_sg_id" {
  description = "Security Group de la app. Lo consume data para abrir el 5432 solo a la app."
  value       = aws_security_group.app.id
}

output "instance_ids" {
  description = "IDs de las EC2 creadas"
  value       = aws_instance.web[*].id
}

# En AWS real sería: aws_lb.this.dns_name
# LocalStack publica los sitios S3 en <bucket>.s3-website.localhost.localstack.cloud:4566
output "app_url" {
  description = "URL pública de la app (la 'puerta de entrada')"
  value       = "http://${aws_s3_bucket.web.bucket}.s3-website.localhost.localstack.cloud:4566"
}
