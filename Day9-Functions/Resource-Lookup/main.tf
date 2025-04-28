resource "azurerm_resource_group" "name" {
  name = "Test-RG"
  location = lookup(var.location,var.environment,lower("dev"))
  tags ={
    environment = var.environment
  }
}

output "Resource_location"{
  value = azurerm_resource_group.name.location
}