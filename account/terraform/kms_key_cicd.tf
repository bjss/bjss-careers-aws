resource "aws_kms_key" "cicd" {
  description             = "Terraform State S3 Bucket"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.cicd_key.json

  tags = {
    Name = "Terraform State S3 Bucket Key"
  }
}

data "aws_iam_policy_document" "cicd_key" {
  statement {
    sid    = "AllowLocalIAMAdministration"
    effect = "Allow"
    actions = [
      "*",
    ]
    resources = [
      "*",
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.aws_account_id}:root", #FIXME: Reduce permissions on key admin
      ]
    }
  }

  statement {
    sid    = "AllowManagedAccountsToUse"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyPair",
      "kms:GenerateDataKeyPairWithoutPlaintext",
      "kms:GenerateDataKeyWithoutPlaintext",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:ListGrants",
      "kms:ListResourceTags",
      "kms:ReEncrypt",
      "kms:TagResource",
    ]
    resources = [
      "*",
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.aws_account_id}:root",
      ]
    }
  }
}
