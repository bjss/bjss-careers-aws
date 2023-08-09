resource "aws_dynamodb_table" "terraform_statelock" {
  name         = "${var.project}-terraform-statelock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State lock table for account ${var.aws_account_id} in region ${var.region}"
  }
}
