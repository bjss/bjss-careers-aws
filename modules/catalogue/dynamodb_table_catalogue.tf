resource "aws_dynamodb_table" "catalogue" {
  name         = "${local.prefix}-catalogue"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "image_name"

  attribute {
    name = "image_name"
    type = "S"
  }
}
