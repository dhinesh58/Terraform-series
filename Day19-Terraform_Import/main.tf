#Import RG
resource "azurerm_resource_group" "RG" {
  name     = var.RG_name
  location = var.location
  tags = {
    "Anisha" = "Dhinesh"
  }
}

#Virtual Network
resource "azurerm_virtual_network" "Vnet" {
  name                = var.Vnet_Name
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  address_space       = var.address_space
}

#Subnet
resource "azurerm_subnet" "Subnet" {
  name                 = var.Subnet_name
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = var.address_prefixes
}
