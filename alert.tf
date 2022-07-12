module "alert" {
  count          = var.slack_url == null ? 0 : 1
  source         = "github.com/champ-oss/terraform-aws-alert.git?ref=b2f725dbab0d2e0c61655493296084d1f9af68c0"
  git            = local.id
  log_group_name = aws_cloudwatch_log_group.this.name
  name           = local.id
  filter_pattern = var.filter_pattern
  slack_url      = var.slack_url
  region         = data.aws_region.this.name
}
