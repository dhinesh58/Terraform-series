# Create Virtual network 
resource "azurerm_virtual_network" "name" {
  name = "${var.name}-Network"
  address_space = [element(var.address_space,0)]
  location = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
}

# Create a Subnet 
resource "azurerm_subnet" "name" {
  name = "${var.name}-Internet"
  resource_group_name = azurerm_resource_group.name.name
  virtual_network_name = azurerm_virtual_network.name.name
  address_prefixes = ["${element(var.address_space ,1)}/${element(var.address_space ,2)}"]
}

# Create A NIC
resource "azurerm_network_interface" "name" {
    name = "${var.name}-NIC"
    location = azurerm_resource_group.name.location
    resource_group_name = azurerm_resource_group.name.name
    ip_configuration {
      name = "Test"
      subnet_id = azurerm_subnet.name.id
      private_ip_address_allocation = "Dynamic"
    }
  
}