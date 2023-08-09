locals {
  environment = terraform.workspace == "default" ? "prd" : terraform.workspace
  prefix      = "${var.project}-${local.environment}-${var.component}"

  identifiers = {
    region                              = var.region
    project                             = var.project
    component                           = var.component
    environment                         = local.environment
    aws_account_id                      = var.aws_account_id
    app_prefix                          = "${var.project}-${local.environment}-${var.component}"
    app_bucket_prefix                   = "${var.project}-${var.aws_account_id}-${var.region}-${local.environment}-${var.component}"
    app_deployer_role_arn               = "arn:aws:iam::322411843910:role/TECHTESTAccountDeployRole"
    account_admin_role_arn              = "arn:aws:iam::${var.aws_account_id}:role/aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_Administrator_13edb3b19d3fd0cc"
    account_admin_role_simple_arn       = "arn:aws:iam::${var.aws_account_id}:role/AWSReservedSSO_Administrator_13edb3b19d3fd0cc"
    candidates_role_arn                 = data.terraform_remote_state.account.outputs.candidates_role_arn
    any_authorised_user_in_this_account = "arn:aws:iam::${var.aws_account_id}:root"
    permissions_boundary_arn            = data.terraform_remote_state.account.outputs.permissions_boundary_arn
    cicd_bucket_name                    = data.terraform_remote_state.account.outputs.cicd_bucket_name
  }

  deployment_default_tags = {
    AccountId   = var.aws_account_id
    AccountName = "bjss-careers"
    Project     = var.project
    Component   = var.component
    Module      = var.module
    Environment = local.environment
  }

  nat_gateway_public_ips_with_cidr_suffix = [
    for address in data.terraform_remote_state.account.outputs.nat_gateway_public_ips :
    "${address}/32"
  ]
}
