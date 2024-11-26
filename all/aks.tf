resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  lifecycle {
    ignore_changes = all
  }
}

resource "azurerm_container_registry" "main" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = false

  lifecycle {
    ignore_changes = [
      sku,
      admin_enabled,
    ]
  }
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.aks_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = var.aks_name

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_DS3_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = var.kubernetes_version

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.0.0.0/16"
    dns_service_ip = "10.0.0.10"
  }
}

resource "azurerm_role_assignment" "acrpull" {

  scope = azurerm_container_registry.main.id

  role_definition_name = "AcrPull"

  principal_id = azurerm_kubernetes_cluster.main.identity.0.principal_id

}

resource "null_resource" "attach_acr" {
  provisioner "local-exec" {
    command = "az aks update --name ${azurerm_kubernetes_cluster.main.name} --resource-group ${azurerm_kubernetes_cluster.main.resource_group_name} --attach-acr ${azurerm_container_registry.main.name}"
  }

  depends_on = [azurerm_kubernetes_cluster.main, azurerm_container_registry.main]
}


resource "null_resource" "update_kube_config" {
  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${azurerm_kubernetes_cluster.main.resource_group_name} --name ${azurerm_kubernetes_cluster.main.name}"
  }

  depends_on = [azurerm_kubernetes_cluster.main, azurerm_role_assignment.acrpull, null_resource.attach_acr]
}
