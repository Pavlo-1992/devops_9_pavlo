data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "kube-system"
  }

  depends_on = [helm_release.nginx_ingress] # якщо ти назвав helm_release саме так
}

