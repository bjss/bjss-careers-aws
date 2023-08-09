resource "aws_iam_policy" "permissions_boundary" {
  name        = "${local.prefix}-permissions-boundary"
  description = "Limits maximum allowable access to AWS services"
  policy      = data.aws_iam_policy_document.permissions_boundary.json
}

data "aws_iam_policy_document" "permissions_boundary" {
  statement {
    sid    = "RestrictRegion"
    effect = "Allow"
    actions = [
      "access-analyzer:*",
      "acm:*",
      "apigateway:*",
      "application-autoscaling:*",
      "autoscaling:*",
      "aws-portal:ViewBilling",
      "budgets:*",
      "cloudshell:*",
      "cloudtrail:*",
      "cloudwatch:*",
      "config:*",
      "dynamodb:*",
      "ec2:*",
      "ec2messages:*",
      "ecr:*",
      "ecs:*",
      "eks:*",
      "elasticloadbalancing:*",
      "events:*",
      "execute-api:*",
      "firehose:*",
      "guardduty:*",
      "health:*",
      "iam:*",
      "imagebuilder:*",
      "kms:*",
      "lambda:*",
      "logs:*",
      "oam:*",
      "pi:*",
      "resource-groups:*",
      "route53:*",
      "route53domains:*",
      "s3:*",
      "secretsmanager:*",
      "securityhub:*",
      "servicequotas:*",
      "sns:*",
      "sqs:*",
      "ssm:*",
      "ssmmessages:*",
      "sts:AssumeRole",
      "sts:GetServiceBearerToken",
      "tag:*",
      "waf:*",
      "wafv2:*",
      "xray:*",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values = [
        "eu-west-2",
      ]
    }
  }

  statement {
    sid    = "RestricttoUseast1"
    effect = "Allow"
    actions = [
      "acm:*",
      "aws-portal:ViewBilling",
      "cloudfront:*",
      "cloudwatch:*",
      "ec2:describeRegions",
      "guardduty:*",
      "health:*",
      "iam:*",
      "kms:*",
      "lambda:*",
      "logs:*",
      "route53:*",
      "s3:*",
      "sns:*",
      "ssm:*",
      "sts:AssumeRole",
      "tag:*",
      "trustedadvisor:*",
      "waf:*",
      "wafv2:*",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values = [
        "us-east-1",
      ]
    }
  }

  statement {
    # Only allow restricted policies to be Attached or Detached to/from Roles
    sid    = "DenyIAMPolicyActions"
    effect = "Deny"
    actions = [
      "iam:AddClientIDToOpenIDConnectProvider",
      "iam:AddRoleToInstanceProfile",
      "iam:AddUserToGroup",
      "iam:AttachGroupPolicy",
      "iam:AttachUserPolicy",
      "iam:AttachGroupPolicy",
      "iam:AttachUserPolicy",
      "iam:C*",
      "iam:Dea*",
      "iam:Del*",
      "iam:DetachGroupPolicy",
      "iam:DetachUserPolicy",
      "iam:E*",
      "iam:G*",
      "iam:L*",
      "iam:P*",
      "iam:R*",
      "iam:S*",
      "iam:T*",
      "iam:U*"
    ]
    resources = ["*"]
    condition {
      test     = "ArnLike"
      variable = "iam:PolicyARN"
      values = [
        "arn:aws:iam::${var.aws_account_id}:policy/${local.uppercase_project}*",
      ]
    }
  }

  statement {
    # Don't allow restricted roles to be amended
    sid    = "DenyIAMRoleActions"
    effect = "Deny"
    actions = [
      "iam:AttachRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:DeleteRole",
      "iam:CreateRole",
      "iam:DeleteRolePermissionsBoundary",
      "iam:PutRolePermissionsBoundary",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateRole*",
    ]
    resources = [
      "arn:aws:iam::${var.aws_account_id}:role/${local.uppercase_project}*"
    ]
  }
}

