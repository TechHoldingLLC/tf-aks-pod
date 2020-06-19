resource "kubernetes_service" "svc" {
  for_each = var.versions

  metadata {
    name = "${var.name}-${each.key}"
  }
  spec {
    selector = {
      app     = var.name
      version = each.key
    }

    port {
      port        = each.value.ports.service
      target_port = each.value.ports.container
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_deployment" "pod" {
  for_each = var.versions

  metadata {
    name = "${var.name}-${each.key}"
    labels = {
      app     = var.name
      version = each.key
    }
  }

  spec {
    replicas = each.value.replicas

    selector {
      match_labels = {
        app     = var.name
        version = each.key
      }
    }

    template {
      metadata {
        labels = {
          app     = var.name
          version = each.key
        }
      }

      spec {
        container {
          image             = "${var.image}:${each.value.img_version}"
          name              = var.name
          image_pull_policy = var.image_pull_policy

          port {
            container_port = each.value.ports.container
          }

          env {
            name = "PORT"
            value = each.value.ports.container
          }

          dynamic "env" {
            for_each = each.value.img_env

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
