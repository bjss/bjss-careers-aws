resource "aws_iam_policy" "catalogue_table_readwrite" {
  name        = "${local.prefix}-catalogue-table-readwrite"
  description = "Allows access to modify the content of the catalogue DynamoDB table"
  policy      = data.aws_iam_policy_document.catalogue_table_readwrite.json
}

data "aws_iam_policy_document" "catalogue_table_readwrite" {
  statement {
    sid    = "AllowDynamoDbAccess"
    effect = "Allow"

    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:BatchWriteItem",
      "dynamodb:Scan",
    ]

    resources = [
      aws_dynamodb_table.catalogue.arn,
      "${aws_dynamodb_table.catalogue.arn}/index/*",
    ]
  }
}
