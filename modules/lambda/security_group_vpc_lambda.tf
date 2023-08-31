resource "aws_security_group" "vpc_lambda" {
  count       = length(var.lambda_options.vpc_id) > 0 ? 1 : 0
  name        = "${local.prefix}-lambda"
  vpc_id      = var.lambda_options.vpc_id
  description = "Security group for lambda function in a vpc"

  tags = {
    Name = "${local.prefix}-lambda-vpc-sg"
  }
}

resource "aws_security_group_rule" "vpc_lambda_vpc_ingress_443" {
  count             = length(var.lambda_options.vpc_id) > 0 ? 1 : 0
  description       = "Allow traffic within vpc"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.lambda_options.vpc_cidr_block]
  security_group_id = aws_security_group.vpc_lambda[0].id
}

resource "aws_security_group_rule" "vpc_lambda_vpc_ingress_443_prefix_lists" {
  count       = length(var.lambda_options.vpc_id) > 0 ? 1 : 0
  description = "Allow traffic within vpc"
  type        = "egress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  prefix_list_ids = [
    data.aws_ec2_managed_prefix_list.s3.id,
    data.aws_ec2_managed_prefix_list.dynamodb.id
  ]
  security_group_id = aws_security_group.vpc_lambda[0].id
}

resource "aws_security_group_rule" "vpc_lambda_vpc_ingress_80" {
  count             = length(var.lambda_options.vpc_id) > 0 ? 1 : 0
  description       = "Allow traffic within vpc"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [var.lambda_options.vpc_cidr_block]
  security_group_id = aws_security_group.vpc_lambda[0].id
}
