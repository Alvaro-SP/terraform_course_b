output "logs_bucket_name" {
  description = "Nombre del bucket de logs"
  value       = module.logs_bucket.bucket_name
}

output "logs_bucket_arn" {
  description = "ARN del bucket de logs"
  value       = module.logs_bucket.bucket_arn
}

output "data_bucket_name" {
  description = "Nombre del bucket de data"
  value       = module.data_bucket.bucket_name
}

output "data_bucket_arn" {
  description = "ARN del bucket de data"
  value       = module.data_bucket.bucket_arn
}
