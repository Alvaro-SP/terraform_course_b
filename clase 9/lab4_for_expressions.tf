

locals {
  # Lista → lista. Corchetes [ ] devuelven una lista.
  upper_names = [for n in var.names : upper(n)]

  # Lista → map. Llaves { } y flecha => devuelven un map.
  hostnames = { for n in var.names : n => "web-${n}" }

  # Filtro con if: solo los elementos que cumplen la condición.
  prod = [for e in var.envs : e if e.tier == "prod"]

  # Dos variables en el for sobre un map: clave y valor.
  retencion = { for nombre, config in var.buckets : nombre => "${config.days} días" }
}
