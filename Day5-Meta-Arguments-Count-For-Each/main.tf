
# Create resource group using count 
resource "azurerm_resource_group" "name" {
  #count = length(var.azurerm_resource_group_name)
  for_each = var.azurerm_resource_group_name
  name = each.value
  #name = var.azurerm_resource_group_name[count.index]
  location = "centralindia"
}

