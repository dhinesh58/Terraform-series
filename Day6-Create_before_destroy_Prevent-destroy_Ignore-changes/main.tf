resource "azurerm_resource_group" "name" {
    lifecycle {
      create_before_destroy = false
      # prevent_destroy = true
      ignore_changes = [ name]
    }

  name = "Test"
  location = "centralindia"
  
}

resource "azurerm_storage_account" "name" {
  name = "testacou65"
  resource_group_name = azurerm_resource_group.name.name
  location = azurerm_resource_group.name.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}