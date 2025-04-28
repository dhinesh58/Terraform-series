# Resource Group 
resource "azurerm_resource_group" "RG" {
  name     = "MYSQL-RG"
  location = "centralindia"
}

#Create SQL Server

resource "azurerm_mssql_server" "mySQL" {
  name                         = "dhineshmysql23"
  resource_group_name          = azurerm_resource_group.RG.name
  location                     = azurerm_resource_group.RG.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Testbook@123"
}

#Create a Sample Data base 
resource "azurerm_mssql_database" "mydb" {
  name      = "sample-DB"
  server_id = azurerm_mssql_server.mySQL.id
}

# Create a Firewall rule
resource "azurerm_mssql_firewall_rule" "FR" {
  name             = "FR-Day"
  server_id        = azurerm_mssql_server.mySQL.id
  start_ip_address = "157.49.254.196"
  end_ip_address   = "157.49.254.196"
}
