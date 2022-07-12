locals {
  id         = "${var.name == null ? local.image_name : var.name}-${random_string.this.result}"
  tags       = merge(var.tags, { Name = local.id })
  image_repo = replace(var.image, "/:.*/", "")
  image_name = replace(local.image_repo, "/.*//", "")
}

resource "random_string" "this" {
  length  = 8
  special = false
  upper   = false

  lifecycle {
    ignore_changes = [length, special, upper]
  }
}
