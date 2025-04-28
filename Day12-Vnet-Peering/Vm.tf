resource "azurerm_linux_virtual_machine" "example" {
  name                = "myVM"
  resource_group_name = azurerm_resource_group.name.name
  location            = azurerm_resource_group.name.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Testbook@123"
  network_interface_ids = [
    azurerm_network_interface.name.id
  ]
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  disable_password_authentication = false

}

#Create another VM 

resource "azurerm_linux_virtual_machine" "example1" {
  name                = "myVM2"
  resource_group_name = azurerm_resource_group.name.name
  location            = azurerm_resource_group.name.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Testbook@123"
  network_interface_ids = [
    azurerm_network_interface.name1.id
  ]
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  disable_password_authentication = false

}

