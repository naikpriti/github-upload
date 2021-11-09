resource "azurerm_resource_group" "rg" {
  name     = "test-aks"
  location = "eastus"
}
resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "test-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "testaks"

  default_node_pool {
    name       = "default"
    node_count = "2"
    vm_size    = "standard_d2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
  /*addon_profile {
    http_application_routing {
      enabled = true
    }
  }
  */
  
}