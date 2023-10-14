## --------------------------------------------------------
## Locals
## --------------------------------------------------------
locals {
  name     = var.use_random_name_suffix ? "${var.name}-${random_pet.this[0].id}" : var.name
  name_tag = can(var.tags.Name) ? var.tags.Name : local.name

  rules = {
    for key, value in var.rules :
    key => {
      cidr_blocks              = length(try(value.cidr_blocks, [])) > 0 ? value.cidr_blocks : null
      ipv6_cidr_blocks         = length(try(value.ipv6_cidr_blocks, [])) > 0 ? value.ipv6_cidr_blocks : null
      source_security_group_id = length(try(value.cidr_blocks, [])) == 0 && length(try(value.ipv6_cidr_blocks, [])) == 0 ? value.source_security_group_id : null
      self                     = length(try(value.cidr_blocks, [])) == 0 && length(try(value.ipv6_cidr_blocks, [])) == 0 && try(value.source_security_group_id, null) == null ? true : null
    }
  }
}

## --------------------------------------------------------
## Resources
## --------------------------------------------------------
resource "aws_security_group" "this" {
  name        = local.name
  description = var.description
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.tags, { "Name" = local.name_tag })
}

resource "aws_security_group_rule" "this" {
  for_each = var.rules

  cidr_blocks              = try(local.rules[each.key].cidr_blocks, null)
  description              = try(each.value.description, null)
  from_port                = try(each.value.from_port, 0)
  ipv6_cidr_blocks         = try(local.rules[each.key].ipv6_cidr_blocks, null)
  prefix_list_ids          = try(each.value.prefix_list_ids, null)
  protocol                 = try(each.value.protocol, "TCP")
  security_group_id        = aws_security_group.this.id
  self                     = try(local.rules[each.key].self, null)
  source_security_group_id = try(local.rules[each.key].source_security_group_id, null)
  to_port                  = try(each.value.to_port, 0)
  type                     = try(each.value.type, "ingress")
}

resource "random_pet" "this" {
  count = var.use_random_name_suffix ? 1 : 0

  length = 2

  keepers = {
    description = var.description
    name        = var.name
    vpc_id      = var.vpc_id
  }
}
