resource "azurerm_virtual_network" "name" {
  name                = "Vnet-Peering"
  resource_group_name = azurerm_resource_group.name.name
  location            = azurerm_resource_group.name.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "name" {
  name                 = "Subnet-A"
  virtual_network_name = azurerm_virtual_network.name.name
  resource_group_name  = azurerm_resource_group.name.name
  address_prefixes     = ["10.0.0.0/20"]
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = azurerm_virtual_network.name.name
  resource_group_name  = azurerm_resource_group.name.name
  address_prefixes     = ["10.0.16.0/22"]

}

resource "azurerm_public_ip" "name" {
  name                = "pipipadd1"
  location            = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
  allocation_method   = "Static"
  sku                 = "Standard"

}

resource "azurerm_network_security_group" "name" {
  name                = "MyNSG"
  location            = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name

  security_rule {
    name                       = "allow-http"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  #ssh security rule
  security_rule {
    name                       = "allow-ssh"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "name" {
  subnet_id                 = azurerm_subnet.name.id
  network_security_group_id = azurerm_network_security_group.name.id
}

resource "azurerm_bastion_host" "name" {
  name                = "BastionHost"
  location            = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
  ip_configuration {
    name                 = "BastionIPConfig"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.name.id
  }
}


# Creating another Virtual network 

resource "azurerm_virtual_network" "name1" {
  name                = "Vnet-Peering1"
  resource_group_name = azurerm_resource_group.name.name
  location            = azurerm_resource_group.name.location
  address_space       = ["50.0.0.0/16"]
}

resource "azurerm_subnet" "name1" {
  name                 = "Subnet-A1"
  virtual_network_name = azurerm_virtual_network.name1.name
  resource_group_name  = azurerm_resource_group.name.name
  address_prefixes     = ["50.0.16.0/20"]
}

resource "azurerm_subnet" "bastion1" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = azurerm_virtual_network.name1.name
  resource_group_name  = azurerm_resource_group.name.name
  address_prefixes     = ["50.0.0.0/22"]

}

resource "azurerm_bastion_host" "name1" {
  name                = "BastionHost1"
  location            = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
  ip_configuration {
    name                 = "BastionIPConfig1"
    subnet_id            = azurerm_subnet.bastion1.id
    public_ip_address_id = azurerm_public_ip.name3.id
  }
}


resource "azurerm_public_ip" "name3" {
  name                = "pipipadd7"
  location            = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
  allocation_method   = "Static"
  sku                 = "Standard"

}

resource "azurerm_virtual_network_peering" "name1" {
  name                      = "peer1-2"
  resource_group_name       = azurerm_resource_group.name.name
  virtual_network_name      = azurerm_virtual_network.name.name
  remote_virtual_network_id = azurerm_virtual_network.name1.id

}

resource "azurerm_virtual_network_peering" "name2" {
  name                      = "peer2-1"
  resource_group_name       = azurerm_resource_group.name.name
  virtual_network_name      = azurerm_virtual_network.name1.name
  remote_virtual_network_id = azurerm_virtual_network.name.id

}
