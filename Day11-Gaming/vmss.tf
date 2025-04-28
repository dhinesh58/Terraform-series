resource "azurerm_orchestrated_virtual_machine_scale_set" "name" {
  name                        = "gaming-VMSS"
  location                    = azurerm_resource_group.name.location
  resource_group_name         = azurerm_resource_group.name.name
  sku_name                    = "Standard_D2s_v4"
  instances                   = 3
  platform_fault_domain_count = 1
  user_data_base64            = base64encode(file("userdata.sh"))
  zones                       = [1]
  os_profile {
    linux_configuration {
      disable_password_authentication = false
      admin_username                  = "azureuser"
      admin_password                  = "Testbook@123"
    }
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-LTS-gen2"
    version   = "latest"
  }
  os_disk {
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
  }
  network_interface {
    name                          = "nic"
    primary                       = true
    enable_accelerated_networking = false

    ip_configuration {
      name                                   = "ipconfig"
      primary                                = true
      subnet_id                              = azurerm_subnet.name.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bepool.id]
    }
  }

  boot_diagnostics {
    storage_account_uri = ""
  }
}
