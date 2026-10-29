
resource "aws_s3_bucket" "hola" {
  bucket = "edutek-hola-localstack"

  tags = {
    Clase     = "4"
    ManagedBy = "Terraform"
  }
}

output "bucket" {
  value = aws_s3_bucket.hola.bucket
}

output "arn" {
  value = aws_s3_bucket.hola.arn
}
