resource "azurerm_resource_group" "name" {
  name = "${var.name}-RG"
  location = var.allowed_locations[0]
}