locals {
  prefix        = "${var.identifiers.app_prefix}-${var.module}"
  bucket_prefix = "${var.identifiers.app_bucket_prefix}-${var.module}"

  default_tags = {
    Module = var.module,
  }
}
