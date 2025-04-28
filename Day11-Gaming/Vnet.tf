resource "azurerm_virtual_network" "name" {
  name                = "Gaming-Vnet"
  resource_group_name = azurerm_resource_group.name.name
  location            = azurerm_resource_group.name.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "name" {
  name                 = "SubnetA"
  resource_group_name  = azurerm_resource_group.name.name
  virtual_network_name = azurerm_virtual_network.name.name
  address_prefixes     = ["10.0.0.0/20"]
}

# network security group for the subnet with a rule to allow http, https and ssh traffic
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
  security_rule {
    name                       = "allow-apache"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "name" {
  subnet_id                 = azurerm_subnet.name.id
  network_security_group_id = azurerm_network_security_group.name.id

}

# A public IP address for the load balancer

resource "azurerm_public_ip" "name" {
  name                = "LB-Publiip"
  resource_group_name = azurerm_resource_group.name.name
  location            = azurerm_resource_group.name.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  domain_name_label   = "sholinganallur-rg-host"

}

# A load balancer with a frontend IP configuration and a backend address pool
resource "azurerm_lb" "name" {
  name                = "gaming-LB"
  resource_group_name = azurerm_resource_group.name.name
  location            = azurerm_resource_group.name.location
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "frontend-Ip"
    public_ip_address_id = azurerm_public_ip.name.id
  }
}

resource "azurerm_lb_backend_address_pool" "bepool" {
  name            = "myBackendAddressPool"
  loadbalancer_id = azurerm_lb.name.id

}

#set up load balancer rule from azurerm_lb.name frontend ip to azurerm_lb_backend_address_pool.bepool backend ip port 80 to port 80

resource "azurerm_lb_rule" "name" {
  name                           = "http"
  loadbalancer_id                = azurerm_lb.name.id
  protocol                       = "Tcp"
  frontend_port                  = "80"
  backend_port                   = "80"
  frontend_ip_configuration_name = "frontend-Ip"
  probe_id                       = azurerm_lb_probe.name.id

}

#set up load balancer probe to check if the backend is up
resource "azurerm_lb_probe" "name" {
  name            = "http-probe"
  loadbalancer_id = azurerm_lb.name.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}

#add lb nat rules to allow ssh access to the backend instances
resource "azurerm_lb_nat_rule" "name" {
  name                           = "ssh"
  resource_group_name            = azurerm_resource_group.name.name
  loadbalancer_id                = azurerm_lb.name.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 22
  frontend_ip_configuration_name = "frontend-Ip"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.bepool.id
}

resource "azurerm_public_ip" "natgwpip" {
  name                = "natgw-publicIP"
  location            = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

#add nat gateway to enable outbound traffic from the backend instances
resource "azurerm_nat_gateway" "example" {
  name                    = "nat-Gateway"
  location                = azurerm_resource_group.name.location
  resource_group_name     = azurerm_resource_group.name.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_subnet_nat_gateway_association" "example" {
  subnet_id      = azurerm_subnet.name.id
  nat_gateway_id = azurerm_nat_gateway.example.id
}

# add nat gateway public ip association
resource "azurerm_nat_gateway_public_ip_association" "example" {
  public_ip_address_id = azurerm_public_ip.natgwpip.id
  nat_gateway_id       = azurerm_nat_gateway.example.id
}
