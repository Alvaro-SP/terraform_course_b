
# Instancia 1 del módulo: bucket de logs.
module "logs_bucket" {
  source = "./modules/s3_bucket" # ruta local: empieza con ./ o ../

  bucket_name = "${var.project_name}-logs"
  environment = var.environment # variable del ROOT → input del MÓDULO
}

# Instancia 2 del MISMO módulo: bucket de data.
# Mismo código, distintos argumentos → otro bucket.
module "data_bucket" {
  source = "./modules/s3_bucket"

  bucket_name = "${var.project_name}-data"
  environment = var.environment
}
