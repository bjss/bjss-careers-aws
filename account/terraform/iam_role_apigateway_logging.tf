resource "aws_iam_role" "apigateway_logging" {
  name                 = "${local.prefix}-logging"
  description          = "Role used by API Gateway to write logs"
  assume_role_policy   = data.aws_iam_policy_document.apigateway_assumerole.json
  permissions_boundary = aws_iam_policy.permissions_boundary.arn
}

data "aws_iam_policy_document" "apigateway_assumerole" {
  statement {
    sid    = "ApigAssumeRole"
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "apigateway.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "apigateway_logging" {
  role       = aws_iam_role.apigateway_logging.name
  policy_arn = aws_iam_policy.apigateway_logging.arn
}

resource "aws_iam_policy" "apigateway_logging" {
  name        = "${local.prefix}-logging"
  description = "Policy that grants API Gateway access to write its own logs"
  path        = "/"
  policy      = data.aws_iam_policy_document.apigateway_logging.json
}

data "aws_iam_policy_document" "apigateway_logging" {
  statement {
    sid    = "AllowLogs"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents",
    ]

    resources = [
      format("arn:aws:logs:%s:%s:log-group:*",
        var.region,
        var.aws_account_id,
      ),
    ]
  }
}

