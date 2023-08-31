resource "aws_iam_policy" "bucket_images_readwrite" {
  name        = "${local.prefix}-bucket-images-readwrite"
  description = "Allows access to modify the content of the images folder in the bucket"
  policy      = data.aws_iam_policy_document.bucket_images_readwrite.json
}

data "aws_iam_policy_document" "bucket_images_readwrite" {
  statement {
    sid    = "AllowRWAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = [
      "${aws_s3_bucket.static_assets.arn}/images/*",
      "${aws_s3_bucket.static_assets.arn}/resized/*",
    ]
  }
}
