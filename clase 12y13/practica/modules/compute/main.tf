# MODULO DE COMPUTE = CAPA 2
# SG + EC2 + PUERTA HTTP
# Recibimos en este modulo vpc_ids y subnet_ids <- vienen de network

# SG de la aplicacion
resource "aws_security_group" "app" {
  name        = "${var.app_name}-${var.environment}-app-sg"
  description = "Trafico HTTP hacia la app ${var.app_name}"
  vpc_id      = var.vpc_id # ← dato que vino de la capa network

  ingress {
    description = "HTTP desde Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Salida libre"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    dynamic "egress" {
    for_each = var.db_sg_ids
    content {
        description     = "Salida hacia la base de datos"
        from_port       = 5432
        to_port         = 5432
        protocol        = "tcp"
        security_groups = [egress.value]
    }
  }

  tags = {
    Name = "${var.app_name}-${var.environment}-app-sg"
  }
}

# 2 EC2
resource "aws_instance" "web" {
  count = var.instance_count

  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index)
  vpc_security_group_ids = [aws_security_group.app.id]
    user_data = join("\n", [
    "#!/bin/bash",
    "dnf install -y nginx",
    "echo '<h1>${var.app_name} - ${var.environment} - web ${count.index + 1}</h1>' > /usr/share/nginx/html/index.html",
    "systemctl enable --now nginx",
  ])

  tags = {
    Name = "${var.app_name}-${var.environment}-web-${count.index + 1}"
  }
}
# 3 PUERTA DE ENTRADA
resource "aws_s3_bucket" "web" {
  bucket        = "${var.app_name}-${var.environment}-web"
  force_destroy = true # permite destroy aunque tenga archivos dentro
}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.web.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.web.id
  key          = "index.html"
  content_type = "text/html; charset=utf-8"
  content      = "<h1>${var.app_name} - ${var.environment}</h1><p>Servidores detras de la puerta de entrada: ${join(", ", aws_instance.web[*].id)}</p>"
}
