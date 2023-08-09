locals {
  prefix = "${var.identifiers.app_prefix}-${var.module}"

  default_tags = {
    Module = var.module,
  }
}
