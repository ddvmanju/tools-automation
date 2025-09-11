data "azurerm_resource_group" "main" {
  name = "project-setup1"
}

data "azurerm_subnet" "main" {
  name                 = "vnet-ukwest"
  virtual_network_name = "main"
  resource_group_name  = data.azurerm_resource_group.main.name
}