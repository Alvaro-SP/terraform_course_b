data "local_file" "plantilla" {
    filename = "${path.module}/plantilla.txt"
}

resource "local_file" "readme" {
    filename = "${path.module}/output/${local.nombre_prefijo}-README.txt"
    content = <<-EOT
        Proyecto : ${var.proyecto}
        Ambiente : ${var.ambiente}
        Equipo   : ${local.integrantes}

        ${data.local_file.plantilla.content}
    EOT
}