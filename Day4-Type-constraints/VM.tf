resource "azurerm_virtual_machine" "name" {
  name = "${var.name}-VM"
  location = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
  network_interface_ids = [azurerm_network_interface.name.id]
  vm_size = var.vm_size[1]

  delete_os_disk_on_termination = var.is_delete
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = var.Image.sku
    version   = var.Image.version
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb = var.storage_disk
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}