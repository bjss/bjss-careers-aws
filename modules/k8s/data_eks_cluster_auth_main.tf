data "aws_eks_cluster_auth" "main" {
  name = "${local.prefix}-cluster"
}
