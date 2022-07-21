locals {
  id          = "${local.name}-${random_string.this.result}"
  name        = var.name == null ? local.image_name : var.name
  tags        = merge(var.tags, { Name = local.id })
  image_repo  = replace(var.image, "/:.*/", "")
  image_name  = replace(local.image_repo, "/.*//", "")
  vpc_id      = data.aws_vpcs.this.ids[0]
  environment = merge(var.environment, { SECRETS_SHA = sha256(jsonencode(var.secrets)) })
}

resource "random_string" "this" {
  length  = 8
  special = false
  upper   = false

  lifecycle {
    ignore_changes = [length, special, upper]
  }
}

data "aws_vpcs" "this" {
  tags = var.vpc_tags
}

data "aws_subnets" "this" {
  tags = var.subnet_tags

  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.this.ids[0]]
  }
}

data "aws_security_groups" "this" {
  count = var.lb_enabled ? 1 : 0
  tags  = var.sg_tags

  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.this.ids[0]]
  }
}

data "aws_lb" "this" {
  count = var.lb_enabled ? 1 : 0
  tags  = var.lb_tags
}

data "aws_lb_listener" "this" {
  count             = var.lb_enabled ? 1 : 0
  load_balancer_arn = data.aws_lb.this[0].arn
  port              = var.listener_port
}

data "aws_region" "this" {}
