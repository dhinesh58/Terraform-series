provider "azurerm" {
  features {

  }
}

module "RG" {
  source   = "../Modules/RG"
  RG_name  = "RG-day"
  Location = "centralindia"
}

module "Vnet" {
  source              = "../Modules/VNet"
  resource_group_name = module.RG.azurerm_resource_group_name
  location            = module.RG.location
  address_space       = ["10.0.0.0/16"]
  address_prefixes    = ["10.0.1.0/22"]
}
