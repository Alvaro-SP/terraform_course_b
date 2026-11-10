
resource "aws_instance" "worker_count" {
  count = length(var.workers)

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  user_data                   = "#!/bin/bash\nhostnamectl set-hostname ${var.workers[count.index]}\n"
  user_data_replace_on_change = true

  tags = merge(local.tags, { Name = "count-${var.workers[count.index]}", Lab = "1-trampa" })
}

resource "aws_instance" "worker_foreach" {
  for_each = toset(var.workers)

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  user_data                   = "#!/bin/bash\nhostnamectl set-hostname ${each.key}\n"
  user_data_replace_on_change = true

  tags = merge(local.tags, { Name = "foreach-${each.key}", Lab = "1-trampa" })
}
