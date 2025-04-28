resource "azurerm_resource_group" "name" {
  name = var.resource_group_name == "test" ? "Dev-RG" : "stage-RG"
  location = "centralindia"
}