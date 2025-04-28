#Virtual Machine
resource "azurerm_virtual_network" "name" {
  name                = "My-Vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
}

#Subnet
resource "azurerm_subnet" "name" {
  name                 = "My-Subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.name.name
  address_prefixes     = var.address_prefixes
}

#