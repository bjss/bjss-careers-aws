resource "aws_iam_role" "eks_node" {
  name                 = "${local.prefix}-eks-node"
  description          = "Role provided to the EKS node"
  assume_role_policy   = data.aws_iam_policy_document.eks_node_assumerole.json
  permissions_boundary = var.identifiers.permissions_boundary_arn
}

data "aws_iam_policy_document" "eks_node_assumerole" {
  statement {
    sid    = "EksAssumeRole"
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_node" {
  role       = aws_iam_role.eks_node.name
  policy_arn = aws_iam_policy.eks_node.arn
}

resource "aws_iam_policy" "eks_node" {
  name        = "${local.prefix}-eks-node"
  description = "Permissions provided to EKS node"
  path        = "/"
  policy      = data.aws_iam_policy_document.eks_node.json
}

data "aws_iam_policy_document" "eks_node" {
  statement {
    sid    = "Placeholder"
    effect = "Allow"
    actions = [
      "sts:GetCallerIdentity",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_container_registry" {
  role       = aws_iam_role.eks_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
