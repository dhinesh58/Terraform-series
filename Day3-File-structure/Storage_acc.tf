resource "azurerm_storage_account" "name" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.name.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    env = local.env.Test
  }
}