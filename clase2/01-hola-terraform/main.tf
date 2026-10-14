terraform {
    required_providers {
        local = {
            source = "hashicorp/local" # de donde vamos a descargar hashicorp (registry.terraform.io)
            version = "~> 2.4"
        }
    }
}

# Un recurso siempre tiene 2 etiquetas
# 1. TIPO -> local_file
# 2. NOMBRE -> "hola_terraform"

resource "local_file" "hola_terraform" {
    content = "Hola desde Terraform! en Edutek LATAM!"
    filename = "${path.module}/output/hola.txt"
}