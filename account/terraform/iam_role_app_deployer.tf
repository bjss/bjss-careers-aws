# resource "aws_iam_role" "app_deployer" {
#   name                 = "${local.uppercase_project}AppDeployer-${local.environment}"
#   description          = "Role used to deploy the tech test application"
#   assume_role_policy   = data.aws_iam_policy_document.app_deployer_assumerole.json
#   permissions_boundary = aws_iam_policy.permissions_boundary.arn
# }

# data "aws_iam_policy_document" "app_deployer_assumerole" {
#   statement {
#     sid    = "AllowAssumeRole"
#     effect = "Allow"
#     actions = [
#       "sts:AssumeRole",
#       "sts:TagSession",
#     ]
#     principals {
#       type = "AWS"
#       identifiers = [
#         "arn:aws:iam::${var.aws_account_id}:role/${local.account_admin_role_name}",
#         "arn:aws:iam::${var.aws_account_id}:role/${local.prefix}-githubrunner",
#       ]
#     }
#   }
# }

# resource "aws_iam_role_policy_attachment" "app_deployer" {
#   role       = aws_iam_role.app_deployer.name
#   policy_arn = aws_iam_policy.app_deployer.arn
# }

# resource "aws_iam_policy" "app_deployer" {
#   name        = "${local.uppercase_project}AppDeployer"
#   description = "Allows CICD runner to deploy AWS resources"
#   policy      = data.aws_iam_policy_document.app_deployer.json
# }

# data "aws_iam_policy_document" "app_deployer" {
#   statement {
#     sid    = "AppDeploy"
#     effect = "Allow"
#     actions = [
#       "access-analyzer:*",
#       "acm:*",
#       "apigateway:*",
#       "application-autoscaling:*",
#       "autoscaling:*",
#       "aws-portal:ViewBilling",
#       "budgets:*",
#       "cloudfront:*",
#       "cloudshell:*",
#       "cloudtrail:*",
#       "cloudwatch:*",
#       "config:*",
#       "dynamodb:*",
#       "ec2:*",
#       "ec2messages:*",
#       "ecr:*",
#       "ecs:*",
#       "eks:*",
#       "elasticloadbalancing:*",
#       "events:*",
#       "execute-api:*",
#       "firehose:*",
#       "guardduty:*",
#       "health:*",
#       "iam:AddRoleToInstanceProfile",
#       "iam:AttachRolePolicy",
#       "iam:CreateInstanceProfile",
#       "iam:CreatePolicy",
#       "iam:CreatePolicyVersion",
#       "iam:DeleteInstanceProfile",
#       "iam:DeletePolicy",
#       "iam:DeletePolicyVersion",
#       "iam:DeleteRole",
#       "iam:DeleteRolePolicy",
#       "iam:DetachRolePolicy",
#       "iam:GetAccountSummary",
#       "iam:GetInstanceProfile",
#       "iam:GetPolicy",
#       "iam:GetPolicyVersion",
#       "iam:GetRole",
#       "iam:GetRolePolicy",
#       "iam:ListAccountAliases",
#       "iam:ListAttachedRolePolicies",
#       "iam:ListEntitiesForPolicy",
#       "iam:ListInstanceProfiles",
#       "iam:ListInstanceProfilesForRole",
#       "iam:ListPolicies",
#       "iam:ListPolicyVersions",
#       "iam:ListRolePolicies",
#       "iam:ListRoleTags",
#       "iam:ListRoles",
#       "iam:ListServerCertificates",
#       "iam:PassRole",
#       "iam:PutRolePolicy",
#       "iam:RemoveRoleFromInstanceProfile",
#       "iam:SimulatePrincipalPolicy",
#       "iam:Tag*",
#       "iam:Untag*",
#       "iam:UpdateAssumeRolePolicy",
#       "iam:UpdateRoleDescription",
#       "kms:CancelKeyDeletion",
#       "kms:CreateAlias",
#       "kms:CreateGrant",
#       "kms:CreateKey",
#       "kms:DeleteAlias",
#       "kms:DescribeKey",
#       "kms:DisableKeyRotation",
#       "kms:EnableKey",
#       "kms:EnableKeyRotation",
#       "kms:GetKeyPolicy",
#       "kms:GetKeyRotationStatus",
#       "kms:ListAliases",
#       "kms:ListGrants",
#       "kms:ListKeyPolicies",
#       "kms:ListKeys",
#       "kms:ListResourceTags",
#       "kms:ListRetirableGrants",
#       "kms:PutKeyPolicy",
#       "kms:RetireGrant",
#       "kms:RevokeGrant",
#       "kms:ScheduleKeyDeletion",
#       "kms:TagResource",
#       "kms:UntagResource",
#       "kms:UpdateAlias",
#       "kms:UpdateKeyDescription",
#       "lambda:*",
#       "logs:*",
#       "oam:*",
#       "pi:*",
#       "resource-groups:*",
#       "route53:*",
#       "route53domains:*TagsForDomain",
#       "route53domains:ListDomains",
#       "s3:*",
#       "secretsmanager:*",
#       "securityhub:*",
#       "servicequotas:*",
#       "sns:*",
#       "sqs:*",
#       "ssm:*",
#       "tag:*",
#       "waf:*",
#       "wafv2:*",
#       "xray:*",
#     ]
#     resources = [
#       "*",
#     ]
#   }

#   statement {
#     # Only allow creation of a new role if that role applies the permission boundary
#     sid    = "SetPermissionsBoundary"
#     effect = "Allow"
#     actions = [
#       "iam:CreateRole",
#     ]
#     resources = [
#       "arn:aws:iam::*:role/*",
#     ]
#     condition {
#       test     = "StringEquals"
#       variable = "iam:PermissionsBoundary"
#       values = [
#         aws_iam_policy.permissions_boundary.arn,
#       ]
#     }
#   }

#   statement {
#     sid    = "AllowManagementOfServiceRole"
#     effect = "Allow"
#     actions = [
#       "iam:CreateServiceLinkedRole",
#       "iam:DeleteServiceLinkedRole",
#       "iam:GetServiceLinkedRoleDeletionStatus",
#       "iam:UpdateRoleDescription",
#     ]
#     resources = [
#       "arn:aws:iam::*:role/aws-service-role/*",
#     ]
#   }

#   statement {
#     sid    = "AllowKMSviaService"
#     effect = "Allow"
#     actions = [
#       "kms:Encrypt",
#       "kms:Decrypt",
#       "kms:ReEncrypt*",
#       "kms:GenerateDataKey*",
#       "kms:DescribeKey",
#       "kms:CreateGrant",
#       "kms:ListGrants",
#       "kms:RevokeGrant",
#     ]
#     resources = ["*"]
#     condition {
#       test     = "StringLike"
#       variable = "kms:ViaService"
#       values = [
#         "ssm.*.amazonaws.com",
#         "s3.*.amazonaws.com",
#         "sns.*.amazonaws.com",
#         "ec2.*.amazonaws.com",
#       ]
#     }
#   }
# }


