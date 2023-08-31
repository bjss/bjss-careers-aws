resource "aws_iam_policy" "basic_auth" {
  name        = "${local.prefix}-basic-auth"
  description = "Allows the basic auth lambda to read parameters from SSM"
  policy      = data.aws_iam_policy_document.basic_auth.json
}

data "aws_iam_policy_document" "basic_auth" {
  statement {
    sid    = "AllowSsmAccess"
    effect = "Allow"

    actions = [
      "ssm:GetParameter",
    ]

    resources = [
      "arn:aws:ssm:${var.identifiers.region}:${var.identifiers.aws_account_id}:parameter/auth/*"
    ]
  }
}
