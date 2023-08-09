resource "aws_s3_bucket_notification" "update_catalogue" {
  depends_on = [
    aws_lambda_permission.image_bucket_new_objects
  ]

  bucket = module.cdn_origin_s3.bucket_id

  lambda_function {
    lambda_function_arn = module.lambda_update_catalogue.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "images/"
    filter_suffix       = ".jpg"
  }
}

resource "aws_lambda_permission" "image_bucket_new_objects" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_update_catalogue.lambda_function_arn
  principal     = "s3.amazonaws.com"
  source_arn    = module.cdn_origin_s3.bucket_arn
}
