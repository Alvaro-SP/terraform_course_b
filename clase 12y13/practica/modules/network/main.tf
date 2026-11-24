# MODULO NETWORK CAPA 1

# VPC + 2 SUBREDES PUBLICAS + 2 PRIVADAS + IG + TABLA DE RUTEO

# 1. vpc
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.environment}"
  }
}
# 2. Subnets PUBLICAS
# cidrsubnet("10.0.0.0/16", 8, 0)    -> 10.0.0.0/24
# cidrsubnet("10.0.0.0/16", 8, 1)    -> 10.0.1.0/24
resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true # las EC2 de aquí reciben IP pública

  tags = {
    Name = "subnet-pub-${var.environment}-${count.index + 1}"
    Tier = "public"
  }
}
# 3. subnets PRIVADAS
#  10.0.10.0/24 ... 10.0.11.0/24
resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index + 10)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "subnet-priv-${var.environment}-${count.index + 1}"
    Tier = "private"
  }
}
# 4. ig LA PUERTa de la vpc hacia internet
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "igw-${var.environment}"
  }
}
# 5 tabla de ruteo publica
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "rt-public-${var.environment}"
  }
}
