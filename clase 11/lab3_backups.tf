module "backups_bucket" {
  source = "./modules/s3_bucket"

  bucket_name = "${var.project_name}-backups"
  environment = "prod"
}

output "backups_bucket_arn" {
  description = "ARN del bucket de backups"
  value       = module.backups_bucket.bucket_arn
}
