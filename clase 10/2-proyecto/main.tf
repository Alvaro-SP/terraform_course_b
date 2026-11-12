locals {
  env = terraform.workspace

  instance_type  = lookup(var.instance_type, terraform.workspace, "t2.micro")
  instance_count = lookup(var.instance_count, terraform.workspace, 1)

  tags = {
    Env      = local.env
    Proyecto = "edutek"
    Clase    = "10"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "web" {
  count = local.instance_count

  ami           = data.aws_ami.amazon_linux.id
  instance_type = local.instance_type

  tags = merge(local.tags, {
    Name = "web-${local.env}-${count.index + 1}"
  })
}

resource "aws_s3_bucket" "assets" {
  bucket = "edutek-${local.env}-assets"
  tags   = local.tags
}
