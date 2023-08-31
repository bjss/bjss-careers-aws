resource "aws_iam_policy" "administer_candidates" {
  name        = "${local.prefix}-administer-candidates"
  description = "Allows the GitHub Runner to administer candidates in IAM and SSM Parameter Store"
  policy      = data.aws_iam_policy_document.administer_candidates.json
}

data "aws_iam_policy_document" "administer_candidates" {
  statement {
    sid    = "AllowIAMAccess"
    effect = "Allow"
    actions = [
      "iam:CreateUser",
      "iam:CreateLoginProfile",
      "iam:AddUserToGroup",
      "iam:DeleteUser",
      "iam:DeleteLoginProfile",
      "iam:RemoveUserFromGroup",
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "AllowSsmAccess"
    effect = "Allow"
    actions = [
      "ssm:PutParameter",
      "ssm:DeleteParameter",
    ]
    resources = [
      "arn:aws:ssm:${local.identifiers.region}:${local.identifiers.aws_account_id}:parameter/auth/*"
    ]
  }
}

