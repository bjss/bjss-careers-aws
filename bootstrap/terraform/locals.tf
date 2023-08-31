locals {
  prefix = "${var.project}-${var.component}"

  uppercase_project       = upper(var.project)
  account_admin_role_name = "aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_Administrator_13edb3b19d3fd0cc"

  deployment_default_tags = {
    AccountId   = var.aws_account_id
    AccountName = "bjss-careers"
    Project     = var.project
    Component   = var.component
    Module      = var.module
  }
}
