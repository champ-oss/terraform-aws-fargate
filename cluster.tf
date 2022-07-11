resource "aws_ecs_cluster" "this" {
  count = 1
  name  = var.name
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  count              = 1
  cluster_name       = aws_ecs_cluster.this[0].name
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 1
    weight            = 100
  }
}
