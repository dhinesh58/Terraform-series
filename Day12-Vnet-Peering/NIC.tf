resource "azurerm_network_interface" "name" {
  name                = "my-NIC"
  resource_group_name = azurerm_resource_group.name.name
  location            = azurerm_resource_group.name.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.name.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "name1" {
  name                = "my-NIC1"
  resource_group_name = azurerm_resource_group.name.name
  location            = azurerm_resource_group.name.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.name1.id
    private_ip_address_allocation = "Dynamic"
  }
}

