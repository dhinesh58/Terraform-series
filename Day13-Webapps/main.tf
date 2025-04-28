# # Create a Resource Group 
# resource "azurerm_resource_group" "RG" {
#   name     = "${var.prefix}-RG"
#   location = "canadacentral"
# }

# # Create a web app service plan 
# resource "azurerm_service_plan" "name" {
#   name                = "${var.prefix}-APP_Service_plan"
#   resource_group_name = azurerm_resource_group.RG.name
#   location            = azurerm_resource_group.RG.location
#   os_type             = "Linux"
#   sku_name            = "P1v2"
# }

# # Create a Web App service 
# resource "azurerm_linux_web_app" "example" {
#   name                = "${var.prefix}-WEBAPP"
#   resource_group_name = azurerm_resource_group.RG.name
#   location            = azurerm_resource_group.RG.location
#   service_plan_id     = azurerm_service_plan.name.id
#   site_config {}
# }

# # Create a web service slot 
# resource "azurerm_linux_web_app_slot" "name" {
#   name           = "${var.prefix}-Staging"
#   app_service_id = azurerm_linux_web_app.example.id
#   site_config {

#   }
# }

# #Create a source control 

# resource "azurerm_app_service_source_control" "name" {
#   app_id   = azurerm_linux_web_app.example.id
#   repo_url = "https://github.com/dhinesh58/web_app.git"
#   branch   = "master"

# }


# # Create control slot

# resource "azurerm_app_service_source_control_slot" "name" {
#   slot_id  = azurerm_linux_web_app_slot.name.id
#   repo_url = "https://github.com/dhinesh58/web_app.git"
#   branch   = "appServiceSlot_Working_DO_NOT_MERGE"
# }

# resource "azurerm_web_app_active_slot" "name" {
#   slot_id = azurerm_linux_web_app_slot.name.id
# }

variable "prefix" {
  default = "Webapp-day10"
  type    = string
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = "canadacentral"
}
resource "azurerm_app_service_plan" "asp" {
  name                = "${var.prefix}-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "as" {
  name                = "${var.prefix}-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
}

resource "azurerm_app_service_slot" "slot" {
  name                = "${var.prefix}-staging"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  app_service_name    = azurerm_app_service.as.name
}

resource "azurerm_app_service_source_control" "scm" {
  app_id   = azurerm_app_service.as.id
  repo_url = "https://github.com/dhinesh58/web_app.git"
  branch   = "master"
}

resource "azurerm_app_service_source_control_slot" "scm1" {
  slot_id  = azurerm_app_service_slot.slot.id
  repo_url = "https://github.com/dhinesh58/web_app.git"
  branch   = "appServiceSlot_Working_DO_NOT_MERGE"
}

resource "azurerm_web_app_active_slot" "active" {
  slot_id = azurerm_app_service_slot.slot.id

}
