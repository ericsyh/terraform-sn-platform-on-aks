provider "azurerm" {
  features {}
}

resource "random_pet" "suffix" {}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "aks-sn-platform-${random_pet.suffix.id}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-sn-platform"
  kubernetes_version  = "1.23.12"

  default_node_pool {
    name            = "default"
    node_count      = 3
    vm_size         = "Standard_B4ms"
    os_disk_size_gb = 250
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "sn-platform"
  }
}