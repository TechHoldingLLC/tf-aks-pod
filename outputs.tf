output "pods" {
  value = kubernetes_deployment.pod
}

output "svc" {
  value = kubernetes_service.svc
}
