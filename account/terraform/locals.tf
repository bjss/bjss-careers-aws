locals {
  environment = terraform.workspace == "default" ? "prd" : terraform.workspace
  prefix      = "${var.project}-${local.environment}-${var.component}"

  uppercase_project       = upper(var.project)
  account_admin_role_name = "aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_Administrator_13edb3b19d3fd0cc"

  identifiers = {
    region                    = var.region
    project                   = var.project
    component                 = var.component
    environment               = local.environment
    aws_account_id            = var.aws_account_id
    app_prefix                = "${var.project}-${local.environment}-${var.component}"
    account_deployer_role_arn = "arn:aws:iam::322411843910:role/TECHTESTAccountDeployRole"
    account_admin_role_arn    = "arn:aws:iam::${var.aws_account_id}:role/${local.account_admin_role_name}"
    any_user_in_this_account  = "arn:aws:iam::${var.aws_account_id}:root"
    permissions_boundary_arn  = aws_iam_policy.permissions_boundary.arn
    cicd_bucket_name          = aws_s3_bucket.cicd.bucket
  }

  deployment_default_tags = {
    AccountId   = var.aws_account_id
    AccountName = "bjss-careers"
    Project     = var.project
    Component   = var.component
    Module      = var.module
    Environment = local.environment
  }
}
