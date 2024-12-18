resource "helm_release" "istio-base" {
  depends_on = [ null_resource.update_kube_config ]
  chart            = "base"
  namespace        = var.istio_namespace
  create_namespace = "true"
  name             = "istio-base"
  version          = var.istio_version
  repository       = "https://istio-release.storage.googleapis.com/charts"
  #force_update     = var.force_update
  #recreate_pods    = var.recreate_pods
}

resource "helm_release" "istiod" {
  depends_on        = [helm_release.istio-base]
  name              = "istiod"
  namespace         = var.istio_namespace
  dependency_update = true
  repository        = "https://istio-release.storage.googleapis.com/charts"
  chart             = "istiod"
  version           = var.istio_version
  atomic            = true
  lint              = true

#   postrender {
#     binary_path = "${path.module}/istiod-kustomize/kustomize.sh"
#     args        = ["${path.module}"]
#   }
#   values = [
#     yamlencode(
#       {
#         meshConfig = {
#           accessLogFile = "/dev/stdout"
#         }
#       }
#     )
#   ]
}

# $ helm install istio-ingress istio/gateway -n istio-ingress --wait

resource "helm_release" "istio-ingress" {
  depends_on        = [helm_release.istio-base, helm_release.istiod]
  name              = "istio-ingress"
  namespace         = var.istio_namespace
  create_namespace  = "true"
  dependency_update = true
  repository        = "https://istio-release.storage.googleapis.com/charts"
  chart             = "gateway"
  version           = var.istio_version
  atomic            = true
#   postrender {
#     binary_path = "${path.module}/gateway-kustomize/kustomize.sh"
#     args        = ["${path.module}"]
#   }
#   values = [
#     yamlencode(
#       {
#         labels = {
#           app   = ""
#           istio = "ingressgateway"
#         }
#       }
#     )
#   ]
#   lint = true
}
