locals {
  container = {
    name         = "this"
    environment  = [for key, value in local.environment : { name = key, value = value }]
    essential    = true
    image        = var.image
    portMappings = [{ containerPort = var.port }]

    secrets = [
      for parameter in aws_ssm_parameter.this : {
        name = replace(parameter.name, "/.*//", ""), valueFrom = parameter.name
      }
    ]

    logConfiguration = {
      logDriver = "awslogs"

      options = {
        awslogs-group         = aws_cloudwatch_log_group.this.name
        awslogs-region        = data.aws_region.this.name
        awslogs-stream-prefix = "fargate"
      }
    }
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = local.id
  container_definitions    = jsonencode([local.container])
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.this.arn
  task_role_arn            = aws_iam_role.this.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  tags                     = local.tags
}

resource "aws_ecs_service" "this" {
  name                              = local.name
  cluster                           = aws_ecs_cluster.this.arn
  depends_on                        = [aws_lb_listener_rule.this]
  desired_count                     = var.min_capacity
  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  launch_type                       = "FARGATE"
  propagate_tags                    = "SERVICE"
  task_definition                   = aws_ecs_task_definition.this.arn
  wait_for_steady_state             = var.wait_for_steady_state
  enable_execute_command            = var.enable_execute_command
  tags                              = local.tags

  network_configuration {
    subnets          = data.aws_subnets.this.ids
    security_groups  = [aws_security_group.this.id]
    assign_public_ip = var.assign_public_ip
  }

  dynamic "load_balancer" {
    for_each = var.lb_enabled ? [""] : []

    content {
      target_group_arn = aws_lb_target_group.this[0].id
      container_name   = local.container.name
      container_port   = var.port
    }
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}
