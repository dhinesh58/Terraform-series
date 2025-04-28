data "azurerm_resource_group" "name" {
  name = var.data_RG
}

data "azurerm_virtual_network" "name" {
  name = var.data_vnet_name
  resource_group_name = data.azurerm_resource_group.name.name
}

data "azurerm_subnet" "name" {
    name = "Dummy"
   virtual_network_name = data.azurerm_virtual_network.name.name
   resource_group_name = data.azurerm_resource_group.name.name
}