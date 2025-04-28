#Resource group
resource "azurerm_resource_group" "RG" {
  name     = "monitor-RG"
  location = "centralindia"
}
#Virtual Network
resource "azurerm_virtual_network" "Vnet" {
  name                = var.Vnet_Name
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  address_space       = var.Vnet_address_space
}

#Subnet 
resource "azurerm_subnet" "Subnet" {
  name                 = var.Subnet_Name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  resource_group_name  = azurerm_resource_group.RG.name
  address_prefixes     = var.address_prefixes
}
#Public IP Address 
resource "azurerm_public_ip" "publicIP" {
  name                = var.PublicIP_Name
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  allocation_method   = "Static"
}

#Network interface 
resource "azurerm_network_interface" "NIC" {
  name                = "My-NIC"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  ip_configuration {
    name                          = "Internal"
    subnet_id                     = azurerm_subnet.Subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicIP.id
  }
}

#NSG
resource "azurerm_network_security_group" "mynsg" {
  name                = "Vm-NSG"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  security_rule {
    name                       = "SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "http"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#NSG Assocation 
resource "azurerm_network_interface_security_group_association" "NSA" {
  network_interface_id      = azurerm_network_interface.NIC.id
  network_security_group_id = azurerm_network_security_group.mynsg.id
}

#Virtual Machine
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
