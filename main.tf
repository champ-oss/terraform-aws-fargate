locals {
  id          = "${local.name}-${random_string.this.result}"
  name        = var.name == null ? local.image_name : var.name
  tags        = merge(var.tags, { Name = local.id })
  image_repo  = replace(var.image, "/:.*/", "")
  image_name  = replace(local.image_repo, "/.*//", "")
  vpc_id      = data.aws_vpc.this.id
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

data "aws_vpc" "this" {
  tags = var.vpc_tags
}

data "aws_subnets" "this" {
  tags = var.subnet_tags
}

data "aws_security_group" "this" {
  tags = var.sg_tags
}

data "aws_lb" "this" {
  tags = var.lb_tags
}

data "aws_lb_listener" "this" {
  load_balancer_arn = data.aws_lb.this.arn
  port              = var.listener_port
}

data "aws_region" "this" {}
