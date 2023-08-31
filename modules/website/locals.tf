locals {
  prefix = "${var.identifiers.app_prefix}-${var.module}"

  default_tags = {
    Module = var.module,
  }

  cloudfront_fqdn = format("%s%s.%s",
    var.identifiers.environment == "prd" ? "" : "${var.identifiers.environment}-",
    var.identifiers.project,
    data.aws_route53_zone.bjsscareers.name
  )
}
