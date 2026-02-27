resource "helm_release" "this" {
  name             = var.name
  repository       = var.repository
  chart            = var.chart
  version          = var.version
  namespace        = var.namespace
  create_namespace = var.create_namespace
  values           = var.values
}
