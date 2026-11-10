
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "web" {
  count = var.instance_count

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = merge(local.tags, {
    # count.index empieza en 0; con + 1 los nombres quedan web-1 ... web-5
    Name = "web-${count.index + 1}"
    Lab  = "1-count"
  })
}
