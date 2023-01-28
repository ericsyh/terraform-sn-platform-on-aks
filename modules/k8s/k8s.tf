provider "kubernetes" {
  host                   = var.host
  username               = var.username
  password               = var.password
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
}

resource "kubernetes_namespace" "sns" {
  metadata {
    name = "sns"
  }
}

resource "kubernetes_namespace" "snp" {
  metadata {
    name = "snp"
  }
}

resource "kubernetes_service" "streamnative-console" {
  metadata {
    name = "streamnative-console-external"
    namespace = kubernetes_namespace.snp.metadata.0.name
  }
  spec {
    selector = {
      app = "sn-platform"
      component = "streamnative-console"
    }
    port {
      port        = 9527
      target_port = 9527
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_service" "grafana" {
  metadata {
    name = "grafana-external"
    namespace = kubernetes_namespace.snp.metadata.0.name
  }
  spec {
    selector = {
      app = "sn-platform"
      component = "grafana"
    }
    port {
      port        = 3000
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}