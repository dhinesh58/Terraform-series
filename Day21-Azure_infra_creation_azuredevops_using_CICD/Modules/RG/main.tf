#Resource Group
resource "azurerm_resource_group" "name" {
  name     = var.RG_name
  location = var.Location
}
