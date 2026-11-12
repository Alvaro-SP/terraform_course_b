variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  description = "Tipo de instancia según el workspace"
  type        = map(string)
  default = {
    dev   = "t2.micro"
    stage = "t2.small"
    prod  = "t2.large"
  }
}

variable "instance_count" {
  description = "Cuántos servidores web según el workspace"
  type        = map(number)
  default = {
    dev   = 1
    stage = 1
    prod  = 2
  }
}
