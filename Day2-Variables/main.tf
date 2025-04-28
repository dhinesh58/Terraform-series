terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~>4.8.0"
    }
  } 
}

provider "azurerm" {
  features{}
}
locals {
  common_tags ={
    env = "test"
    test = "merge"
  }
}

# Create a Resource group 
resource "azurerm_resource_group" "name" {
  name = var.name
  location = var.location
  tags = {
    env = local.common_tags.test
  }
}

output "resource_group_name_id" {
  value = azurerm_resource_group.name.id
}