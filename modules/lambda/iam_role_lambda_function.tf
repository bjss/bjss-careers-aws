resource "aws_iam_role" "lambda_function" {
  name                 = "${local.prefix}-${var.lambda_options.function_name}"
  description          = "Role provided to lambda function ${var.lambda_options.function_name}"
  assume_role_policy   = data.aws_iam_policy_document.lambda_function_assumerole.json
  permissions_boundary = var.identifiers.permissions_boundary_arn
}

data "aws_iam_policy_document" "lambda_function_assumerole" {
  statement {
    sid    = "LambdaAssumeRole"
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "lambda_function" {
  role       = aws_iam_role.lambda_function.name
  policy_arn = aws_iam_policy.lambda_function.arn
}

resource "aws_iam_policy" "lambda_function" {
  name        = "${local.prefix}-${var.lambda_options.function_name}"
  description = "Permissions provided to lambda function ${var.lambda_options.function_name}"
  path        = "/"
  policy      = data.aws_iam_policy_document.lambda_function.json
}

data "aws_iam_policy_document" "lambda_function" {
  statement {
    sid    = "AllowLogs"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "arn:aws:logs:${var.identifiers.region}:${var.identifiers.aws_account_id}:log-group:/aws/lambda/*",
      "arn:aws:logs:us-east-1:${var.identifiers.aws_account_id}:log-group:/aws/lambda/*"
    ]
  }

  statement {
    sid    = "AllowDescribeNIForSecretsLambda"
    effect = "Allow"

    actions = [
      "ec2:DescribeNetworkInterfaces",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowForCreateUpdateDeleteNIsForSecretsLambda"
    effect = "Allow"

    actions = [
      "ec2:UnassignPrivateIpAddresses",
      "ec2:DeleteNetworkInterface",
      "ec2:CreateNetworkInterface",
      "ec2:AssignPrivateIpAddresses"
    ]

    resources = [
      "arn:aws:ec2:${var.identifiers.region}:${var.identifiers.aws_account_id}:*/*"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "lambda_function_extra" {
  count      = length(var.lambda_options.extra_policy_attachments)
  role       = aws_iam_role.lambda_function.name
  policy_arn = var.lambda_options.extra_policy_attachments[count.index]
}
