terraform {
  required_version = ">= 1.5.0"

  cloud {
    organization = "edutek-latam"

    workspaces {
      name = "edutek-clase10"
    }
  }
}

resource "terraform_data" "saludo" {
  input = "Hola desde HCP Terraform · ${timestamp()}"

  lifecycle {
    ignore_changes = [input]
  }
}

output "saludo" {
  value = terraform_data.saludo.output
}
