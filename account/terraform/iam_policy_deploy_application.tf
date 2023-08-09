resource "aws_iam_policy" "deploy_application" {
  name        = "${local.prefix}-deploy-application"
  description = "Allows access to deploy all of the AWS components of the application"
  policy      = data.aws_iam_policy_document.deploy_application.json
}

data "aws_iam_policy_document" "deploy_application" {
  statement {
    sid    = "ServiceAllowList"
    effect = "Allow"
    actions = [
      "apigateway:*",
      "application-autoscaling:*",
      "autoscaling:*",
      "cloudtrail:*",
      "cloudwatch:*",
      "config:*",
      "dynamodb:*",
      "ec2:*",
      "ec2messages:*",
      "ecr:*",
      "ecs:*",
      "elasticloadbalancing:*",
      "events:*",
      "execute-api:*",
      "firehose:*",
      "iam:*",
      "imagebuilder:*",
      "kms:*",
      "lambda:*",
      "logs:*",
      "resource-groups:*",
      "route53:*",
      "route53domains:*",
      "s3:*",
      "ssm:*",
      "ssmmessages:*",
      "sts:AssumeRole",
      "tag:*",
      "waf:*",
      "wafv2:*",
    ]
    resources = [
      "*"
    ]
  }
}

