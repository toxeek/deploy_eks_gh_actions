variable "eks_pod_identity_associations" {
  type        = map(any)
  description = "Map of EKS Pod Associations to be created in EKS."
}

data "aws_iam_policy_document" "pod_identity" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

# loop eks_pod_identity_associations Map to create EKS PodIdentity associations
resource "aws_iam_role" "pod_identity_role" {
  for_each = var.eks_pod_identity_associations

  name               = "eks-pod-identity-${each.key}"
  assume_role_policy = data.aws_iam_policy_document.pod_identity.json
}
resource "aws_iam_role_policy_attachment" "s3_read_only" {
  for_each = var.eks_pod_identity_associations

  policy_arn = each.value.policy_arn
  role       = aws_iam_role.pod_identity_role[each.key].name
}
resource "aws_eks_pod_identity_association" "this" {
  for_each = var.eks_pod_identity_associations

  cluster_name    = var.cluster_name
  service_account = each.value.service_account_name
  namespace       = each.value.service_account_namespace
  role_arn        = aws_iam_role.pod_identity_role[each.key].arn

  depends_on = [kubernetes_namespace.eks_namespaces]
}
