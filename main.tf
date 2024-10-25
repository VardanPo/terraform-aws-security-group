# ------------------------------ Locals ------------------------------
locals {
  sg_id = var.create_sg ? try(aws_security_group.example[0].id, aws_security_group.prefix_example[0].id) : var.security_group_id
}

# ------------------------------ Security group with name ------------------------------
resource "aws_security_group" "example" {
  count = var.create_sg && !var.use_name_prefix ? 1 : 0

  name                   = var.name
  description            = var.description
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )

  timeouts {
    create = var.create_timeout
    delete = var.delete_timeout
  }
}

# ------------------------------ Security group with name_prefix ------------------------------
resource "aws_security_group" "prefix_example" {
  count = var.create_sg && var.use_name_prefix ? 1 : 0

  name_prefix            = "${var.name}-"
  description            = var.description
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    create = var.create_timeout
    delete = var.delete_timeout
  }
}

# ------------------------------ Ingress ------------------------------
resource "aws_security_group_rule" "ingress_example" {
  for_each = length(var.ingress_rules) > 0 ? tomap(var.ingress_rules) : {}

  security_group_id = local.sg_id
  type              = "ingress"

  cidr_blocks              = try(each.value.cidr_blocks, null)
  ipv6_cidr_blocks         = try(each.value.ingress_ipv6_cidr_blocks, null)
  prefix_list_ids          = try(each.value.ingress_prefix_list_ids, null)
  source_security_group_id = try(each.value.source_security_group_id, null)
  description              = try(each.value.description, null)
  self                     = try(each.value.self, null)


  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol
}

# ------------------------------ Egress ------------------------------
resource "aws_security_group_rule" "egress_example" {
  for_each = length(var.egress_rules) > 0 ? tomap(var.egress_rules) : {}

  security_group_id = local.sg_id
  type              = "egress"

  cidr_blocks              = try(each.value.cidr_blocks, null)
  ipv6_cidr_blocks         = try(each.value.ingress_ipv6_cidr_blocks, null)
  prefix_list_ids          = try(each.value.ingress_prefix_list_ids, null)
  source_security_group_id = try(each.value.source_security_group_id, null)
  description              = try(each.value.description, null)
  self                     = try(each.value.self, null)


  from_port = each.value.from_port
  to_port   = each.value.to_port
  protocol  = each.value.protocol
}