resource "aws_iam_role" "candidates" {
  name                 = "${local.uppercase_project}Candidates"
  description          = "Allows Tech Test Candidates to safely explore the account"
  assume_role_policy   = data.aws_iam_policy_document.candidates_assumerole.json
  permissions_boundary = aws_iam_policy.permissions_boundary.arn
}

data "aws_iam_policy_document" "candidates_assumerole" {
  statement {
    sid    = "AllowAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type = "AWS"
      identifiers = [
        local.identifiers.any_user_in_this_account
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "candidates_list_only" {
  role       = aws_iam_role.candidates.name
  policy_arn = aws_iam_policy.candidates_list_only.arn
}

resource "aws_iam_role_policy_attachment" "candidates_unrestricted" {
  role       = aws_iam_role.candidates.name
  policy_arn = aws_iam_policy.candidates_unrestricted.arn
}

resource "aws_iam_role_policy_attachment" "candidates_part_1" {
  role       = aws_iam_role.candidates.name
  policy_arn = aws_iam_policy.candidates_part_1.arn
}

resource "aws_iam_role_policy_attachment" "candidates_part_2" {
  role       = aws_iam_role.candidates.name
  policy_arn = aws_iam_policy.candidates_part_2.arn
}

resource "aws_iam_role_policy_attachment" "candidates_part_3" {
  role       = aws_iam_role.candidates.name
  policy_arn = aws_iam_policy.candidates_part_3.arn
}

resource "aws_iam_role_policy_attachment" "candidates_part_4" {
  role       = aws_iam_role.candidates.name
  policy_arn = aws_iam_policy.candidates_part_4.arn
}

resource "aws_iam_policy" "candidates_list_only" {
  name        = "${local.uppercase_project}Candidates_list_only-${local.environment}"
  description = "Allows Tech Test Candidates to list all resources in the account"
  policy      = data.aws_iam_policy_document.candidates_list_only.json
}

resource "aws_iam_policy" "candidates_unrestricted" {
  name        = "${local.uppercase_project}Candidates_unrestricted-${local.environment}"
  description = "Allows Tech Test Candidates to access resources regardless of tagging"
  policy      = data.aws_iam_policy_document.candidates_unrestricted.json
}

resource "aws_iam_policy" "candidates_part_1" {
  name        = "${local.uppercase_project}Candidates_part_1-${local.environment}"
  description = "Allows Tech Test Candidates to safely explore the account"
  policy      = data.aws_iam_policy_document.candidates_part_1.json
}

resource "aws_iam_policy" "candidates_part_2" {
  name        = "${local.uppercase_project}Candidates_part_2-${local.environment}"
  description = "Allows Tech Test Candidates to safely explore the account"
  policy      = data.aws_iam_policy_document.candidates_part_2.json
}

resource "aws_iam_policy" "candidates_part_3" {
  name        = "${local.uppercase_project}Candidates_part_3-${local.environment}"
  description = "Allows Tech Test Candidates to safely explore the account"
  policy      = data.aws_iam_policy_document.candidates_part_3.json
}

resource "aws_iam_policy" "candidates_part_4" {
  name        = "${local.uppercase_project}Candidates_part_4-${local.environment}"
  description = "Explicitly Prevents Tech Test Candidates from accessing certain actions & resources"
  policy      = data.aws_iam_policy_document.candidates_part_4.json
}

data "aws_iam_policy_document" "candidates_list_only" {
  statement {
    sid    = "CandidatesListOnly"
    effect = "Allow"
    actions = [
      "access-analyzer:ListAnalyzers",
      "access-analyzer:ListFindings",
      "autoscaling:DescribeAccountLimits",
      "autoscaling:DescribeAdjustmentTypes",
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeAutoScalingNotificationTypes",
      "autoscaling:DescribeInstanceRefreshes",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeLifecycleHooks",
      "autoscaling:DescribeLifecycleHookTypes",
      "autoscaling:DescribeLoadBalancers",
      "autoscaling:DescribeLoadBalancerTargetGroups",
      "autoscaling:DescribeMetricCollectionTypes",
      "autoscaling:DescribeNotificationConfigurations",
      "autoscaling:DescribePolicies",
      "autoscaling:DescribeScalingActivities",
      "autoscaling:DescribeScalingProcessTypes",
      "autoscaling:DescribeScheduledActions",
      "autoscaling:DescribeTags",
      "autoscaling:DescribeTerminationPolicyTypes",
      "autoscaling:DescribeTrafficSources",
      "autoscaling:DescribeWarmPool",
      "autoscaling:GetPredictiveScalingForecast",
      "backup:ListBackupVaults",
      "cloudwatch:ListDashboards",
      "cloudwatch:ListMetrics",
      "cloudwatch:ListTagsForResource",
      "dynamodb:ListBackups",
      "dynamodb:ListTables",
      "ec2:Describe*",
      "ec2:List*",
      "eks:ListAddons",
      "eks:ListClusters",
      "eks:ListFargateProfiles",
      "eks:ListIdentityProviderConfigs",
      "eks:ListNodegroups",
      "eks:ListTagsForResource",
      "eks:ListUpdates",
      "events:ListRules",
      "firehose:ListDeliveryStreams",
      "guardduty:ListDetectors",
      "guardduty:ListFindings",
      "iam:ListAccessKeys",
      "iam:ListAccountAliases",
      "iam:ListAttachedGroupPolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListAttachedUserPolicies",
      "iam:ListEntitiesForPolicy",
      "iam:ListGroupPolicies",
      "iam:ListGroups",
      "iam:ListInstanceProfiles",
      "iam:ListInstanceProfilesForRole",
      "iam:ListMFADevices",
      "iam:ListOpenIDConnectProviders",
      "iam:ListPolicies",
      "iam:ListPolicyTags",
      "iam:ListPolicyVersions",
      "iam:ListRolePolicies",
      "iam:ListRoles",
      "iam:ListRoleTags",
      "iam:ListSAMLProviders",
      "iam:ListServerCertificates",
      "iam:ListSSHPublicKeys",
      "iam:ListUserPolicies",
      "iam:ListUserTags",
      "iam:ListVirtualMFADevices",
      "inspector:ListAssessmentRuns",
      "inspector:ListAssessmentTemplates",
      "inspector:ListExclusions",
      "inspector:ListFindings",
      "kinesis:ListStreams",
      "kinesis:ListTagsForStream",
      "kms:ListAliases",
      "kms:ListAliases",
      "kms:ListGrants",
      "kms:ListGrants",
      "kms:ListKeyPolicies",
      "kms:ListKeyPolicies",
      "kms:ListKeys",
      "kms:ListKeys",
      "kms:ListResourceTags",
      "kms:ListResourceTags",
      "lambda:ListAliases",
      "lambda:ListCodeSigningConfigs",
      "lambda:ListEventSourceMappings",
      "lambda:ListFunctionEventInvokeConfigs",
      "lambda:ListFunctions",
      "lambda:ListFunctionsByCodeSigningConfig",
      "lambda:ListFunctionUrlConfigs",
      "lambda:ListLayers",
      "lambda:ListLayerVersions",
      "lambda:ListProvisionedConcurrencyConfigs",
      "lambda:ListVersionsByFunction",
      "rds:ListTagsForResource",
      "route53:ListHostedZones",
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
      "route53:ListTagsForResource",
      "route53domains:ListDomains",
      "route53domains:ListDomains",
      "route53domains:ListTagsForDomain",
      "route53domains:ListTagsForDomain",
      "s3:ListAccessPoints",
      "s3:ListAccessPointsForObjectLambda",
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:ListBucketVersions",
      "s3:ListJobs",
      "s3:ListMultipartUploadParts",
      "s3:ListMultiRegionAccessPoints",
      "s3:ListStorageLensConfigurations",
      "secretsmanager:ListSecrets",
      "sns:ListSubscriptionsByTopic",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTagsForResource",
      "sns:ListTagsForResource",
      "sns:ListTopics",
      "sns:ListTopics",
      "sqs:ListQueues",
      "sqs:ListQueues",
      "sqs:ListQueueTags",
      "sqs:ListQueueTags",
    ]
    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "candidates_unrestricted" {
  statement {
    sid    = "CandidatesUnrestricted"
    effect = "Allow"
    actions = [
      "apigateway:GET",
      "dynamodb:BatchGetItem",
      "dynamodb:ConditionCheckItem",
      "dynamodb:DescribeBackup",
      "dynamodb:DescribeContinuousBackups",
      "dynamodb:DescribeEndpoints",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeReservedCapacity",
      "dynamodb:DescribeReservedCapacityOfferings",
      "dynamodb:DescribeTable",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:ListTagsOfResource",
      "dynamodb:Query",
      "dynamodb:Scan",
      "logs:GetLogEvents",
      "route53:GetDNSSEC",
      "route53:GetGeoLocation",
      "route53domains:GetDomainDetail",
      "s3:DescribeJob",
      "s3:DescribeMultiRegionAccessPointOperation",
      "s3:GetAccelerateConfiguration",
      "s3:GetAccessPoint",
      "s3:GetAccessPointConfigurationForObjectLambda",
      "s3:GetAccessPointForObjectLambda",
      "s3:GetAccessPointPolicy",
      "s3:GetAccessPointPolicyForObjectLambda",
      "s3:GetAccessPointPolicyStatus",
      "s3:GetAccessPointPolicyStatusForObjectLambda",
      "s3:GetAccountPublicAccessBlock",
      "s3:GetAnalyticsConfiguration",
      "s3:GetBucketAcl",
      "s3:GetBucketCORS",
      "s3:GetBucketLocation",
      "s3:GetBucketLogging",
      "s3:GetBucketNotification",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetBucketOwnershipControls",
      "s3:GetBucketPolicy",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketRequestPayment",
      "s3:GetBucketTagging",
      "s3:GetBucketVersioning",
      "s3:GetBucketWebsite",
      "s3:GetEncryptionConfiguration",
      "s3:GetIntelligentTieringConfiguration",
      "s3:GetInventoryConfiguration",
      "s3:GetJobTagging",
      "s3:GetLifecycleConfiguration",
      "s3:GetMetricsConfiguration",
      "s3:GetMultiRegionAccessPoint",
      "s3:GetMultiRegionAccessPointPolicy",
      "s3:GetMultiRegionAccessPointPolicyStatus",
      "s3:GetMultiRegionAccessPointRoutes",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectAttributes",
      "s3:GetObjectLegalHold",
      "s3:GetObjectRetention",
      "s3:GetObjectTagging",
      "s3:GetObjectTorrent",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionAttributes",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionTagging",
      "s3:GetObjectVersionTorrent",
      "s3:GetReplicationConfiguration",
      "s3:GetStorageLensConfiguration",
      "s3:GetStorageLensConfigurationTagging",
      "s3:GetStorageLensDashboard",
      "cloudshell:CreateEnvironment",
      "cloudshell:CreateSession",
      "cloudshell:DeleteEnvironment",
      "cloudshell:GetEnvironmentStatus",
      "cloudshell:GetFileDownloadUrls",
      "cloudshell:GetFileUploadUrls",
      "cloudshell:PutCredentials",
      "cloudshell:StartEnvironment",
      "cloudshell:StopEnvironment"
    ]
    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "candidates_part_1" {
  statement {
    sid    = "CandidatesPart1"
    effect = "Allow"
    actions = [
      "acm:DescribeCertificate",
      "acm:ListTagsForCertificate",
      "cloudfront:List*",
      "cloudfront:GetDistribution",
      "cloudfront:GetDistributionConfig",
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:DescribeInsightRules",
      "cloudwatch:GetDashboard",
      "cloudwatch:GetInsightRuleReport",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:GetMetricStream",
      "cloudwatch:GetMetricWidgetImage",
      "cloudwatch:ListManagedInsightRules",
      "ec2:Get*",
      "elasticloadbalancing:DescribeAccountLimits",
      "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "iam:GenerateCredentialReport",
      "iam:GenerateCredentialReport",
      "iam:GetAccessKeyLastUsed",
      "iam:GetAccessKeyLastUsed",
      "iam:GetAccountAuthorizationDetails",
      "iam:GetAccountAuthorizationDetails",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:GetAccountSummary",
      "iam:GetCredentialReport",
      "iam:GetCredentialReport",
      "iam:GetGroup",
      "iam:GetGroup",
      "iam:GetGroupPolicy",
      "iam:GetGroupPolicy",
      "iam:GetLoginProfile",
      "iam:GetLoginProfile",
      "iam:GetOpenIDConnectProvider",
      "iam:GetOpenIDConnectProvider",
      "iam:GetPolicy",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetPolicyVersion",
      "iam:GetRole",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:GetRolePolicy",
      "iam:GetSAMLProvider",
      "iam:GetSAMLProvider",
      "iam:GetServerCertificate",
      "iam:GetServerCertificate",
      "iam:GetUser",
      "iam:GetUser",
      "iam:GetUserPolicy",
      "iam:GetUserPolicy",
      "kms:DescribeKey",
      "kms:DescribeKey",
      "kms:GetKeyPolicy",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:GetKeyRotationStatus",
      "lambda:GetAccountSettings",
      "lambda:GetAlias",
      "lambda:GetCodeSigningConfig",
      "lambda:GetEventSourceMapping",
      "lambda:GetFunction",
      "lambda:GetFunctionCodeSigningConfig",
      "lambda:GetFunctionConcurrency",
      "lambda:GetFunctionConfiguration",
      "lambda:GetFunctionEventInvokeConfig",
      "lambda:GetFunctionUrlConfig",
      "lambda:GetLayerVersion",
      "lambda:GetLayerVersionPolicy",
      "lambda:GetPolicy",
      "lambda:GetProvisionedConcurrencyConfig",
      "lambda:GetRuntimeManagementConfig",
      "lambda:ListTags",
      "logs:DescribeLogGroups",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:DescribeMetricFilters",
      "logs:DescribeMetricFilters",
      "logs:DescribeQueryDefinitions",
      "logs:FilterLogEvents",
      "rds:DescribeAccountAttributes",
      "rds:DescribeDBClusters",
      "rds:DescribeDBInstances",
      "rds:DescribeDBParameters",
      "rds:DescribeDBSecurityGroups",
      "rds:DescribeDBSnapshotAttributes",
      "rds:DescribeDBSnapshots",
      "rds:DescribeEvents",
      "rds:DescribeEventSubscriptions",
      "rds:DescribeReservedDBInstances",
      "sns:GetTopicAttributes",
      "sns:GetTopicAttributes",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueAttributes",
      "tag:GetResources",
      "tag:GetResources",
      "tag:GetTagKeys",
      "tag:GetTagKeys",
      "tag:GetTagValues",
      "tag:GetTagValues",
    ]
    resources = [
      "*",
    ]
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:ResourceTag/Project"
      values = [
        "techtest",
      ]
    }
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:ResourceTag/Environment"
      values = [
        "prd",
      ]
    }
  }
}

data "aws_iam_policy_document" "candidates_part_2" {
  statement {
    sid    = "CandidatesPart2"
    effect = "Allow"
    actions = [
      "application-autoscaling:DescribeScalableTargets",
      "application-autoscaling:DescribeScalingActivities",
      "application-autoscaling:DescribeScalingPolicies",
      "application-autoscaling:DescribeScheduledActions",
      "backup:DescribeBackupVault",
      "backup:GetBackupVaultAccessPolicy",
      "compute-optimizer:GetAutoScalingGroupRecommendations",
      "compute-optimizer:GetEC2InstanceRecommendations",
      "dax:DescribeClusters",
      "ecr:BatchGetRepositoryScanningConfiguration",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetLifecyclePolicy",
      "ecr:GetRegistryScanningConfiguration",
      "ecr:GetRepositoryPolicy",
      "ecr:ListTagsForResource",
      "ecs:DescribeContainerInstances",
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition",
      "ecs:ListClusters",
      "ecs:ListContainerInstances",
      "ecs:ListServices",
      "ecs:ListTaskDefinitions",
      "eks:AccessKubernetesApi",
      "eks:DescribeAddon",
      "eks:DescribeAddonConfiguration",
      "eks:DescribeAddonVersions",
      "eks:DescribeCluster",
      "eks:DescribeFargateProfile",
      "eks:DescribeIdentityProviderConfig",
      "eks:DescribeNodegroup",
      "eks:DescribeUpdate",
      "events:DescribeEventBus",
      "guardduty:GetDetector",
      "guardduty:GetFindings",
      "health:DescribeAffectedEntities",
      "health:DescribeEventDetails",
      "health:DescribeEvents",
      "organizations:DescribeAccount",
      "organizations:DescribeCreateAccountStatus",
      "organizations:DescribeHandshake",
      "organizations:DescribeOrganization",
      "organizations:DescribeOrganizationalUnit",
      "organizations:DescribePolicy",
      "s3:GetAccelerateConfiguration",
      "s3:GetAccountPublicAccessBlock",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketLogging",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetBucketPolicy",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketTagging",
      "s3:GetBucketVersioning",
      "s3:GetBucketWebsite",
      "s3:GetEncryptionConfiguration",
      "s3:GetLifecycleConfiguration",
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "secretsmanager:DescribeSecret",
      "securityhub:GetEnabledStandards",
      "securityhub:GetFindings",
      "securityhub:GetInsightResults",
      "securityhub:GetInsights",
      "securityhub:GetMasterAccount",
      "securityhub:GetMembers",
      "securityhub:ListEnabledProductsForImport",
      "securityhub:ListInvitations",
      "securityhub:ListMembers",
      "servicequotas:ListServiceQuotas",
      "ssm:DescribeInstanceInformation",
      "ssm:DescribeParameters",
      "ssm:DescribeSessions",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:ListTagsForResource",
      "waf:GetWebACL",
      "waf:ListWebACLs",
      "wafv2:ListWebACLs",
      "xray:GetEncryptionConfig",
    ]
    resources = [
      "*",
    ]
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:ResourceTag/Project"
      values = [
        "techtest",
      ]
    }
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:ResourceTag/Environment"
      values = [
        "prd",
      ]
    }
  }
}

data "aws_iam_policy_document" "candidates_part_3" {
  statement {
    sid    = "AllowKMSviaService"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant",
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "kms:ViaService"
      values = [
        "ssm.*.amazonaws.com",
        "s3.*.amazonaws.com",
        "sns.*.amazonaws.com",
        "ec2.*.amazonaws.com",
      ]
    }
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:ResourceTag/Project"
      values = [
        "techtest",
      ]
    }
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:ResourceTag/Environment"
      values = [
        "prd",
      ]
    }
  }
  statement {
    sid    = "AllowSessionManager"
    effect = "Allow"
    actions = [
      "ssm:GetConnectionStatus",
      "ssm:StartSession",
    ]
    resources = ["*"]
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:ResourceTag/Project"
      values = [
        "techtest",
      ]
    }
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:ResourceTag/Environment"
      values = [
        "prd",
      ]
    }
  }
}

data "aws_iam_policy_document" "candidates_part_4" {
  statement {
    sid    = "DenySecretsForGitHub"
    effect = "Deny"
    actions = [
      "secretsmanager:GetSecretValue",
    ]
    resources = [
      module.autoscaling_github_runners.github_pat_secret_arn
    ]
  }

  statement {
    sid    = "DenySessionManagerForGitHub"
    effect = "Deny"
    actions = [
      "ssm:StartSession",
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "ssm:resourceTag/aws:autoscaling:groupName"
      values = [
        module.autoscaling_github_runners.auto_scaling_group_name
      ]
    }
  }

  statement {
    sid    = "DenySsmAccess"
    effect = "Deny"
    actions = [
      "ssm:GetParameter",
    ]
    resources = [
      "arn:aws:ssm:${local.identifiers.region}:${local.identifiers.aws_account_id}:parameter/auth/*"
    ]
  }
}
