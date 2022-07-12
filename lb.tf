resource "aws_lb_target_group" "this" {
  name                 = substr(local.id, 0, 32) # AWS-defined 32 character limit
  port                 = var.port
  protocol             = "HTTP"
  vpc_id               = data.aws_vpc.this.id
  target_type          = "ip"
  deregistration_delay = var.deregistration_delay
  tags                 = local.tags

  health_check {
    path                = var.health_check_path
    matcher             = var.matcher
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    interval            = var.interval
    timeout             = var.timeout
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_rule" "this" {
  depends_on   = [aws_lb_target_group.this]
  listener_arn = data.aws_lb_listener.this.arn
  tags         = local.tags

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    host_header {
      values = ["${var.name}.${var.domain}", "${local.id}.${var.domain}", "${var.host}.${var.domain}"]
    }
  }
}
