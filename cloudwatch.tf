resource "aws_cloudwatch_log_group" "this" {
  name              = local.id
  retention_in_days = var.retention_in_days

  lifecycle {
    ignore_changes = [name]
  }
}
