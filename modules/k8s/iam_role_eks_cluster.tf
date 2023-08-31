resource "aws_iam_role" "eks_cluster" {
  name                 = "${local.prefix}-eks-cluster"
  description          = "Role provided to the EKS cluster"
  assume_role_policy   = data.aws_iam_policy_document.eks_cluster_assumerole.json
  permissions_boundary = var.identifiers.permissions_boundary_arn
}

data "aws_iam_policy_document" "eks_cluster_assumerole" {
  statement {
    sid    = "EksAssumeRole"
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "eks.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = aws_iam_policy.eks_cluster.arn
}

resource "aws_iam_policy" "eks_cluster" {
  name        = "${local.prefix}-eks-cluster"
  description = "Permissions provided to EKS cluster"
  path        = "/"
  policy      = data.aws_iam_policy_document.eks_cluster.json
}

data "aws_iam_policy_document" "eks_cluster" {
  statement {
    sid    = "AllowECRAccess"
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings"
    ]

    resources = [
      format("arn:aws:ecrs:%s:%s:repository/%s-*",
        var.identifiers.region,
        var.identifiers.aws_account_id,
        local.prefix,
      )
    ]
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}
