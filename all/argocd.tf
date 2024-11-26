resource "helm_release" "argocd" {
  depends_on = [ helm_release.istio-ingress ]
  name  = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "4.9.7"
  create_namespace = true
}