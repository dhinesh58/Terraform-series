resource "azurerm_resource_group" "name" {
  #name = local.formatted_name
  name     = "${local.formatted_name}-RG"
  location = "centralindia"
}

output "project_name" {
  value = azurerm_resource_group.name.name
}
