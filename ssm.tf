data "aws_kms_secrets" "this" {
  for_each = var.secrets

  secret {
    name    = each.key
    payload = each.values
  }
}

resource "aws_ssm_parameter" "this" {
  for_each = data.aws_kms_secrets.this
  name     = "/fargate/${local.id}/${each.key}"
  type     = "SecureString"
  value    = each.value.plaintext[each.key]
}
