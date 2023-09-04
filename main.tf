provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "sn-platform-aks-rg"
  location = "East US 2"

  tags = {
    environment = "sn-platform"
  }
}

module "aks" {
  source = "./modules/aks"

  location = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  appId = var.appId
  password = var.password
}

module "k8s" {
  source ="./modules/k8s"

  host = module.aks.host
  username = module.aks.username
  password = module.aks.password
  client_certificate = base64decode(module.aks.client_certificate)
  client_key = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}

module "helm" {
  source = "./modules/helm"

  host = module.aks.host
  client_certificate = base64decode(module.aks.client_certificate)
  client_key = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)

  operator_namespace = module.k8s.operator_namespace
  sn_platform_namespace = module.k8s.sn_platform_namespace
}