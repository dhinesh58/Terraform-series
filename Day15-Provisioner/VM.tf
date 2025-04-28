#Virtual Machine
resource "azurerm_linux_virtual_machine" "myVM" {
  name                  = var.VM_Name
  resource_group_name   = azurerm_resource_group.RG.name
  location              = azurerm_resource_group.RG.location
  network_interface_ids = [azurerm_network_interface.NIC.id]
  size                  = var.VM_size
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  disable_password_authentication = false
  computer_name                   = "My-VM"
  admin_username                  = "azureuser"
  admin_password                  = "Testbook@123"

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt-get install -y nginx",
      # Create a sample welcome page
      "echo '<html><body><h1>#Dhinesh with learing Terraform !</h1></body></html>' | sudo tee /var/www/html/index.html",
      #Ngnix Running 
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
    connection {
      type     = "ssh"
      user     = "azureuser"
      password = "Testbook@123"
      host     = self.public_ip_address
    }

  }
}
