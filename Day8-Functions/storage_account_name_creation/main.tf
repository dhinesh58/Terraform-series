resource "azurerm_resource_group" "name" {
  #name = local.formatted_name
  name     = "${local.formatted_name}-RG"
  location = "centralindia"
  tags = local.merge_tags
}


resource "azurerm_storage_account" "name" {
  name = local.storage_formatted
  location = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
  account_replication_type = "LRS"
  account_tier = "Standard"
}


output "project_name" {
  value = azurerm_resource_group.name.name
}

output "storage_accountname" {
  value = azurerm_storage_account.name.name
}