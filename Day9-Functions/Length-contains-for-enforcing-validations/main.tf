resource "azurerm_resource_group" "name" {
  name = "Test-RG"
  location = "centralindia"
}

vm_size = lookup(var.vm_sizes,var.environment,lower("dev"))