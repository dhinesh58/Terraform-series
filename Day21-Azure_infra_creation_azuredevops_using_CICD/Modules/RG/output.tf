output "azurerm_resource_group_name" {
  value = azurerm_resource_group.name.name
}

output "location" {
  value = azurerm_resource_group.name.location
}
