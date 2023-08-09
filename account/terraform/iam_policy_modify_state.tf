resource "aws_iam_policy" "modify_state" {
  name        = "${local.prefix}-modify-state"
  description = "Allows access to modify the content of the terraform state bucket"
  policy      = data.aws_iam_policy_document.modify_state.json
}

data "aws_iam_policy_document" "modify_state" {
  statement {
    sid    = "AllowS3Access"
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:Head*",
      "s3:List*",
      "s3:DeleteObject*",
      "s3:PutObject*",
    ]
    resources = [
      data.terraform_remote_state.bootstrap.outputs.state_bucket_arn,
      "${data.terraform_remote_state.bootstrap.outputs.state_bucket_arn}/*",
    ]
  }

  statement {
    sid    = "AllowKMSSecrets"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:ListGrants",
      "kms:ListResourceTags",
      "kms:ReEncrypt*",
    ]
    resources = [
      data.terraform_remote_state.bootstrap.outputs.state_bucket_key,
    ]
  }

  statement {
    sid    = "AllowDynamoDbAccess"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
    ]
    resources = [
      data.terraform_remote_state.bootstrap.outputs.state_lock_table_arn,
    ]
  }
}

