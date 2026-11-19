
provider "aws" {
  region = var.aws_region

  # Credenciales falsas: solo sirven para LocalStack.
  access_key = "test"
  secret_key = "test"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  # Si borras este bloque, Terraform hablaría con AWS REAL.
  endpoints {
    s3  = "http://localhost:4566"
    sts = "http://localhost:4566"
  }
}
