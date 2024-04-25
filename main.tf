## --------------------------------------------------------
## Locals
## --------------------------------------------------------
locals {
  name     = var.use_random_name_suffix ? "${var.name}-${random_id.this[0].id}" : var.name
  tag_name = can(var.tags.Name) ? var.tags.Name : local.name

  rules = {
    for key, value in var.rules :
    key => {
      cidr_blocks              = length(try(value.cidr_blocks, [])) > 0 ? value.cidr_blocks : null
      ipv6_cidr_blocks         = length(try(value.ipv6_cidr_blocks, [])) > 0 ? value.ipv6_cidr_blocks : null
      source_security_group_id = length(try(value.cidr_blocks, [])) == 0 && length(try(value.ipv6_cidr_blocks, [])) == 0 && try(value.source_security_group_id, null) != null ? value.source_security_group_id : null
      self                     = try(value.self, null) == true || (length(try(value.cidr_blocks, [])) == 0 && length(try(value.ipv6_cidr_blocks, [])) == 0 && try(value.source_security_group_id, null) == null) ? true : null
      from_port                = try(value.port, value.from_port, 0)
      to_port                  = try(value.port, value.to_port, 0)
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

  tags = merge(var.tags, { "Name" = local.tag_name })
}

resource "aws_security_group_rule" "this" {
  for_each = var.rules

  security_group_id = aws_security_group.this.id

  description              = try(each.value.description, null)
  type                     = try(each.value.type, "ingress")
  cidr_blocks              = local.rules[each.key].cidr_blocks
  ipv6_cidr_blocks         = local.rules[each.key].ipv6_cidr_blocks
  protocol                 = try(each.value.protocol, "TCP")
  from_port                = local.rules[each.key].from_port
  to_port                  = local.rules[each.key].to_port
  prefix_list_ids          = try(each.value.prefix_list_ids, null)
  self                     = local.rules[each.key].self
  source_security_group_id = local.rules[each.key].source_security_group_id
}

resource "random_id" "this" {
  count = var.use_random_name_suffix ? 1 : 0

  byte_length = var.random_byte_length

  keepers = {
    description = var.description
    name        = var.name
    vpc_id      = var.vpc_id
  }
}
