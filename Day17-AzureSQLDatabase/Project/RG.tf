#Create a Resource Group 
resource "azurerm_resource_group" "RG" {
  name     = var.RG_Name
  location = var.location
}
