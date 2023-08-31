resource "aws_cloudwatch_log_group" "eks_cluster" {
  name              = "/aws/eks/${local.prefix}-cluster/cluster"
  retention_in_days = 7
}
