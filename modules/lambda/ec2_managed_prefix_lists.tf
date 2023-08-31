data "aws_ec2_managed_prefix_list" "s3" {
  name = "com.amazonaws.${var.identifiers.region}.s3"
}

data "aws_ec2_managed_prefix_list" "dynamodb" {
  name = "com.amazonaws.${var.identifiers.region}.dynamodb"
}
