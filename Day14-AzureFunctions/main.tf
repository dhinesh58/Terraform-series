# Create a Resource Group 
resource "azurerm_resource_group" "RG" {
  name     = "Day-14-RG"
  location = "centralindia"
}
# Create a Storage Account to store a QR codes
resource "azurerm_storage_account" "SA" {
  name                     = "dhineshwithaf58"
  resource_group_name      = azurerm_resource_group.RG.name
  location                 = azurerm_resource_group.RG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
# Create a App service plan 
resource "azurerm_service_plan" "SP" {
  name                = "dhineshSP"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  os_type             = "Linux"
  sku_name            = "B1"
}
# Create a Azure function using linux OS
resource "azurerm_linux_function_app" "example" {
  name                = "AFdinesh"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location

  storage_account_name       = azurerm_storage_account.SA.name
  storage_account_access_key = azurerm_storage_account.SA.primary_access_key
  service_plan_id            = azurerm_service_plan.SP.id

  site_config {
    application_stack {
      node_version = "18"
    }
  }
}



