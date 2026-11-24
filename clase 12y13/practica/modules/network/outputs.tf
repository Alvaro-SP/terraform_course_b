output "vpc_id" {
  description = "ID de la VPC. Lo consumen compute y data."
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Subnets públicas. Las consume compute (EC2 / ALB)."
  value       = aws_subnet.public[*].id # [*] = splat: la lista de todos los id
}

output "private_subnet_ids" {
  description = "Subnets privadas. Las consume data (base de datos)."
  value       = aws_subnet.private[*].id
}

output "default_sg_id" {
  description = "Security Group por defecto que AWS crea con la VPC."
  value       = aws_vpc.this.default_security_group_id
}
