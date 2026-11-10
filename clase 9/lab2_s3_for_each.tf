
resource "aws_s3_bucket" "backup" {
  count = var.create_backup ? 1 : 0

  bucket = "${local.prefijo}-backup"
  tags   = merge(local.tags, { Lab = "2-interruptor" })
}

resource "aws_s3_bucket" "area" {
  for_each = toset(var.areas)

  bucket = "${local.prefijo}-area-${each.key}"
  tags   = merge(local.tags, { Area = each.key, Lab = "2-set" })
}

resource "aws_s3_bucket" "this" {
  for_each = var.buckets

  bucket = "${local.prefijo}-${each.key}"

  tags = merge(local.tags, {
    Versioned = each.value.versioning
    Retention = each.value.days
    Lab       = "2-map"
  })
}

resource "aws_s3_bucket_versioning" "this" {
  for_each = { for nombre, config in var.buckets : nombre => config if config.versioning }

  # Mismo each.key → encontramos "su" bucket en el resource de arriba.
  bucket = aws_s3_bucket.this[each.key].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  for_each = var.buckets

  bucket = aws_s3_bucket.this[each.key].id

  rule {
    id     = "expirar-objetos"
    status = "Enabled"

    filter {} # vacío = aplica a todos los objetos del bucket

    expiration {
      days = each.value.days
    }
  }
}
