# ejemplo 1, recurso condicional + lifecycle
# count = condicion ? 1 : 0
resource "aws_s3_bucket" "bucket_principal" {
  count  = var.crear_bucket_principal ? 1 : 0
  bucket = "${local.nombre_prefijo}-principal" # mi-app-desarrollo-principal

  tags = merge(
    local.etiquetas_estandar,
    {
      Nombre      = "bucket-principal"
      Descripcion = "Bucket principal..."
    }
  )

  lifecycle {
    prevent_destroy = false #false: el recurso se puede destruir; true: si intentan destruirlo se de tiene con error
    ignore_changes  = [tags["Descripcion"]]
  }
}

# EJEMPLO 2 count: N copias del mismo recurso
resource "aws_s3_bucket" "buckets_con_count" {
  count = var.cantidad_buckets
  # count.index va a empezar en 0
  bucket = "${local.nombre_prefijo}-count-${count.index + 1}" #[ 0  1  2 ]
  # mi-app-prod-count-1
  # mi-app-prod-count-2
  # mi-app-prod-count-3
  tags = merge(
    local.etiquetas_estandar,
    {
      Nombre = "bucket-count-${count.index + 1}"
      Indice = tostring(count.index)
    }
  )

}

# EJEMPLO 3 For_each sobre un map: 
resource "aws_s3_bucket" "buckets_con_foreach" {
  for_each = var.buckets_por_ambiente
  # | vuelta |   each.key    |   each.value   |
  # |   1    |   "desarrollo"    |  "app-dev-bucket"   |
  # |   2    |   "testing"    |  "app-test-bucket"   |
  # |   3    |   "produccion"    |  "app-prod-bucket"   |
  bucket = "${each.value}-${var.ambiente}"
  tags = merge(
    local.etiquetas_estandar,
    {
      Nombre = "bucket-foreach-${each.key}"
    }
  )
}
# EJEMPLO 4 count + conndicional
resource "aws_s3_bucket_versioning" "buckets_versioning" {
  count = var.habilitar_versioning ? var.cantidad_buckets : 0

  # Referencia → dependencia implícita: NO hace falta depends_on
  bucket = aws_s3_bucket.buckets_con_count[count.index].id

  versioning_configuration {
    status = "Enabled"
  }
}

# EJEMPLO 5 foreach sobre otro recurso
resource "aws_s3_bucket_public_access_block" "bloqueo_publico" {
  for_each = aws_s3_bucket.buckets_con_foreach

  bucket = each.value.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ejemplo 6: depends_on:
resource "aws_s3_bucket" "bucket_condicional" {
  count = var.crear_recursos_adicionales && var.cantidad_buckets > 2 ? 1 : 0

  bucket = "${local.nombre_prefijo}-condicional"

  tags = merge(
    local.etiquetas_estandar,
    { Nombre = "bucket-condicional" }
  )

  depends_on = [aws_s3_bucket_public_access_block.bloqueo_publico]
}
# ejemplo 7 formas o comparacion de foreach con count

# equipos = ["backend", "datos"]

resource "aws_s3_bucket" "equipo_count" {
  count  = length(var.equipos)
  bucket = "${local.nombre_prefijo}-c-${var.equipos[count.index]}"
}

resource "aws_s3_bucket" "equipo_foreach" {
  for_each = toset(var.equipos) # for_each no acepta listas: se convierten a set
  bucket   = "${local.nombre_prefijo}-f-${each.key}"
}
