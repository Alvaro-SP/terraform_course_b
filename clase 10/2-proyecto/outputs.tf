output "workspace" {
  value = terraform.workspace
}

output "instance_type" {
  value = local.instance_type
}

output "servidores" {
  value = aws_instance.web[*].tags.Name
}

output "bucket" {
  value = aws_s3_bucket.assets.bucket
}
