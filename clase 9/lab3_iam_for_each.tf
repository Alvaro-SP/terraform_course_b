
resource "aws_iam_user" "team" {
  for_each = local.usuarios

  name = "${local.prefijo}-${each.key}" # edutek-dev-alvaro

  tags = merge(local.tags, {
    Role  = each.value.role
    Group = each.value.group
    Lab   = "3-iam"
  })
}

resource "aws_iam_group" "team" {
  for_each = local.grupos

  name = "${local.prefijo}-${each.key}"
}

resource "aws_iam_user_group_membership" "team" {
  for_each = local.usuarios

  user   = aws_iam_user.team[each.key].name
  groups = [aws_iam_group.team[each.value.group].name]
}
