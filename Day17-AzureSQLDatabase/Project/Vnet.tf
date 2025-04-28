#Create Virtual network
resource "azurerm_virtual_network" "Vnet" {
  name                = "Vnet-mssql"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  address_space       = var.address_space
}

#Create Subnet 
resource "azurerm_subnet" "name" {
  name                 = "SubnetA"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = var.address_prefixes
}
#Create a public ip address
resource "azurerm_public_ip" "name" {
  name                = "mypip"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  allocation_method   = "Static"
}

# Create NIC 
resource "azurerm_network_interface" "name" {
  name                = "my-NIC"
  resource_group_name = azurerm_public_ip.name.name
  location            = azurerm_resource_group.RG.location
  ip_configuration {
    name                          = "my-ip"
    subnet_id                     = azurerm_subnet.name.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.name.id
  }
}

# Create network security group 
resource "azurerm_network_security_group" "nsg" {
  name                = "my-NSG"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location

  security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.name.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
