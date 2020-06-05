resource "kubernetes_service" "svc" {
  metadata {
    name = var.name
  }
  spec {
    selector = {
      app = var.name
    }

    port {
      port        = var.ports.service
      target_port = var.ports.container
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_deployment" "pod" {
  metadata {
    name = var.name
    labels = {
      app = var.name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.name
      }
    }

    template {
      metadata {
        labels = {
          app = var.name
        }
      }

      spec {
        container {
          image = var.image
          name  = var.name

          port {
            container_port = var.ports.container
          }

          dynamic "env" {
            for_each = var.image_env

            content {
              name  = env.key
              value = env.value
            }
          }
        }
      }
    }
  }
}
