## --------------------------------------------------------
## Tags
## --------------------------------------------------------
locals {
  tag_Name = length(lookup(var.tags, "Name", "")) > 0 ? lookup(var.tags, "Name") : local.name

  rules = {
    for key, value in var.rules :
    key => {
      cidr_blocks              = length(try(value.cidr_blocks, [])) > 0 ? value.cidr_blocks : null
      ipv6_cidr_blocks         = length(try(value.ipv6_cidr_blocks, [])) > 0 ? value.ipv6_cidr_blocks : null
      source_security_group_id = length(try(value.cidr_blocks, [])) == 0 && length(try(value.ipv6_cidr_blocks, [])) == 0 ? value.source_security_group_id : null
      self                     = length(try(value.cidr_blocks, [])) == 0 && length(try(value.ipv6_cidr_blocks, [])) == 0 && try(value.source_security_group_id, null) == null ? true : null
    }
  }

  name = try(length(var.name_prefix), 0) == 0 ? var.name : "${var.name_prefix}${random_string.this[0].result}"
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

  tags = merge(var.tags, { "Name" = local.tag_Name })
}

resource "aws_security_group_rule" "this" {
  for_each = var.rules

  security_group_id        = aws_security_group.this.id
  type                     = try(each.value.type, "ingress")
  from_port                = try(each.value.from_port, 0)
  to_port                  = try(each.value.to_port, 0)
  protocol                 = try(each.value.protocol, "TCP")
  description              = try(each.value.description, null)
  prefix_list_ids          = try(each.value.prefix_list_ids, null)
  self                     = try(local.rules[each.key].self, null)
  cidr_blocks              = try(local.rules[each.key].cidr_blocks, null)
  ipv6_cidr_blocks         = try(local.rules[each.key].ipv6_cidr_blocks, null)
  source_security_group_id = try(local.rules[each.key].source_security_group_id, null)
}

resource "random_string" "this" {
  count = try(length(var.name_prefix), 0) == 0 ? 0 : 1

  length  = var.name_suffix_length
  special = false

  keepers = {
    name_prefix = var.name_prefix
  }
}
