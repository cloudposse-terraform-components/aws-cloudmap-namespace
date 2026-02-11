locals {
  enabled = module.this.enabled
}

resource "aws_service_discovery_private_dns_namespace" "default" {
  count       = local.enabled && var.type == "private" ? 1 : 0
  name        = module.this.id
  description = var.description
  vpc         = module.vpc.outputs.vpc_id
}

resource "aws_service_discovery_public_dns_namespace" "default" {
  count       = local.enabled && var.type == "public" ? 1 : 0
  name        = module.this.id
  description = var.description
}

resource "aws_service_discovery_http_namespace" "default" {
  count       = local.enabled && var.type == "http" ? 1 : 0
  name        = module.this.id
  description = var.description
}

resource "aws_security_group" "default" {
  count       = local.enabled && var.create_security_group ? 1 : 0
  name        = module.this.id
  description = "Allow all outbound traffic to any IPv4 address"
  vpc_id      = module.vpc.outputs.vpc_id
}

resource "aws_security_group_rule" "allow_all_egress" {
  count             = local.enabled && var.create_security_group ? 1 : 0
  security_group_id = one(aws_security_group.default[*].id)
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
