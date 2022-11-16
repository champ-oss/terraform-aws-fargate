locals {
  id          = "${local.name}-${random_string.this.result}"
  name        = var.name == null ? local.image_name : var.name
  tags        = merge(var.tags, { Name = local.id })
  image_repo  = replace(var.image, "/:.*/", "")
  image_name  = replace(local.image_repo, "/.*//", "")
  vpc_found   = length(data.aws_vpcs.this.ids) > 0
  vpc_id      = local.vpc_found ? data.aws_vpcs.this.ids[0] : aws_vpc.this[0].id
  subnets     = local.vpc_found ? data.aws_subnets.this[0].ids : aws_subnet.this[*].id
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

resource "aws_vpc" "this" {
  count      = local.vpc_found ? 0 : 1
  cidr_block = "10.0.0.0/16"
  tags       = local.tags
}

resource "aws_route" "this" {
  count                  = local.vpc_found ? 0 : 1
  route_table_id         = aws_vpc.this[0].default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
}

resource "aws_internet_gateway" "this" {
  count  = local.vpc_found ? 0 : 1
  vpc_id = aws_vpc.this[0].id
  tags   = local.tags
}

data "aws_subnets" "this" {
  count = local.vpc_found ? 0 : 1
  tags  = var.subnet_tags

  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
}

resource "aws_subnet" "this" {
  count      = local.vpc_found ? 0 : 2
  vpc_id     = local.vpc_id
  cidr_block = "10.0.${count.index}.0/24"
  tags       = local.tags
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
