variable "aws_region" {
  description = "Región de AWS dondes se despliega la infra."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto (se usa en tags y nombres de recursos)."
  type        = string
  default     = "edutek"
}

variable "vpc_cidr" {
  description = "Rango de IPs (CIDR) de la vpc"
  type        = string
  default     = "10.0.0.0/16" # 65536 ips
}

variable "public_subnet_cidr" {
  description = "Rango de IPs (CIDR) de la subnet pública; debe estar dentro de la VPC"
  type        = string
  default     = "10.0.1.0/24" # 256 IPs
}
variable "instance_type" {
  description = "Tipo (tamaño) de la instancia EC2"
  type        = string
  default     = "t2.micro"
}