data "aws_iam_policy_document" "irsa_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.oidc_provider_arn, "arn:aws:iam::", "")}:sub"
      values   = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
    }
  }
}

resource "aws_iam_role" "irsa" {
  name               = "${var.cluster_name}-${var.service_account}"
  assume_role_policy = data.aws_iam_policy_document.irsa_assume.json
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.irsa.name
  policy_arn = var.policy_arn
}
