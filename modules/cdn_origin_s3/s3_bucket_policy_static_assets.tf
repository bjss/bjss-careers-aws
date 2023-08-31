resource "aws_s3_bucket_policy" "static_assets" {
  bucket = aws_s3_bucket.static_assets.id
  policy = data.aws_iam_policy_document.static_assets_bucket_policy.json
}

data "aws_iam_policy_document" "static_assets_bucket_policy" {
  statement {
    sid     = "AllowOaiGetObject"
    actions = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.static_assets.arn}/*"
    ]

    principals {
      type = "AWS"
      identifiers = [
        var.identifiers.any_authorised_user_in_this_account,
        var.cloudfront_origin_access_identity_iam_arn,
      ]
    }
  }

  statement {
    sid     = "AllowAllToListBucket"
    actions = ["s3:ListBucket"]
    resources = [
      aws_s3_bucket.static_assets.arn
    ]

    principals {
      type = "AWS"
      identifiers = [
        var.identifiers.any_authorised_user_in_this_account,
        var.cloudfront_origin_access_identity_iam_arn,
      ]
    }
  }

  statement {
    sid     = "DenyAllIfNotSecureTransport"
    effect  = "Deny"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.static_assets.arn,
      "${aws_s3_bucket.static_assets.arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        false
      ]
    }
  }
}
