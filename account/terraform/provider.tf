# The default AWS provider in the default region
provider "aws" {
  region = var.region

  allowed_account_ids = [
    var.aws_account_id,
  ]

  assume_role {
    role_arn     = "arn:aws:iam::322411843910:role/TECHTESTAccountDeployRole"
    session_name = "${var.project}-${local.environment}-${var.component}"
  }

  default_tags {
    tags = local.deployment_default_tags
  }
}
