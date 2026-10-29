
output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.main.id
}
output "public_subnet_id" {
  description = "ID de la subnet publica"
  value       = aws_subnet.public.id
}
output "security_group_id" {
  description = "ID del security group"
  value       = aws_security_group.web.id
}
output "instance_id" {
  description = "ID de la instancia"
  value       = aws_instance.web.id
}
output "instance_public_ip" {
  description = "IP publica de la instancia"
  value       = aws_instance.web.public_ip
}
output "web_url" {
  description = "URL para abrirla"
  value       = "http://${aws_instance.web.public_ip}"
}


