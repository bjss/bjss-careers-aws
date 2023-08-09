# The default AWS provider in the default region
provider "aws" {
  region = var.region

  allowed_account_ids = [
    var.aws_account_id,
  ]

  default_tags {
    tags = local.deployment_default_tags
  }
}
