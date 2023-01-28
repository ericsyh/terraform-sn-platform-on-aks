output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
}

output "host" {
  value = azurerm_kubernetes_cluster.default.kube_config.0.host
}

output "username" {
  value = azurerm_kubernetes_cluster.default.kube_config.0.username
}

output "password" {
  value = azurerm_kubernetes_cluster.default.kube_config.0.password
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.default.kube_config.0.client_certificate
}

output "client_key" {
  value = azurerm_kubernetes_cluster.default.kube_config.0.client_key
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate
}
