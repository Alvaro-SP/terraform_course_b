

# ejemplo 1, recurso condicional + lifecycle
# count = condicion ? 1 : 0
resource "aws_s3_bucket" "bucket_principal" {
    count = var.crear_bucket_principal ? 1: 0
    bucket = "${local.nombre_prefijo}-principal" # mi-app-desarrollo-principal

    lifecycle {
        prevent_destroy = false
        ignore_changes = [tags["Descripcion"]]
    }
}