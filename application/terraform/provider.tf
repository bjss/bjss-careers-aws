# The default AWS provider in the default region
provider "aws" {
  region = var.region

  allowed_account_ids = [
    var.aws_account_id,
  ]

  assume_role {
    role_arn     = local.identifiers.app_deployer_role_arn
    session_name = local.identifiers.app_prefix
  }

  default_tags {
    tags = local.deployment_default_tags
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"

  allowed_account_ids = [
    var.aws_account_id,
  ]

  assume_role {
    role_arn     = local.identifiers.app_deployer_role_arn
    session_name = local.identifiers.app_prefix
  }

  default_tags {
    tags = local.deployment_default_tags
  }
}
