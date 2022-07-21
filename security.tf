resource "aws_security_group" "this" {
  name   = local.id
  vpc_id = local.vpc_id
  tags   = local.tags
}

resource "aws_security_group_rule" "egress" {
  description       = "internet"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress" {
  count                    = var.lb_enabled ? 1 : 0
  description              = "alb"
  type                     = "ingress"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = data.aws_security_groups.this[0].ids[0]
}
