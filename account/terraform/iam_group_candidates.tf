resource "aws_iam_group" "candidates" {
  name = "${local.uppercase_project}Candidates-${local.environment}"
}

resource "aws_iam_group_policy_attachment" "candidates" {
  group      = aws_iam_group.candidates.name
  policy_arn = aws_iam_policy.candidates_user.arn
}

resource "aws_iam_policy" "candidates_user" {
  name        = "${local.uppercase_project}CandidateUser-${local.environment}"
  description = "Allows Tech Test Candidates to assume the candidates role"
  policy      = data.aws_iam_policy_document.candidates_user.json
}

data "aws_iam_policy_document" "candidates_user" {
  statement {
    sid    = "CandidateAssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      aws_iam_role.candidates.arn,
    ]
  }
  statement {
    sid    = "CandidateUser"
    effect = "Allow"
    actions = [
      "iam:CreateAccessKey",
      "iam:GetAccessKeyLastUsed",
      "iam:GetUser",
      "iam:ListAccessKeys",
      "iam:ListGroupsForUser",
      "iam:ListMFADevices",
      "iam:ListSigningCertificates",
      "iam:ListSSHPublicKeys",
      "iam:ListUserTags",
      "iam:UpdateAccessKey",
      "iam:DeleteAccessKey",
    ]
    resources = [
      "arn:aws:iam::*:user/$${aws:username}"
    ]
  }
}
