resource "azurerm_resource_group" "rg" {
  name     = "Test-RG"
  location = "centralindia"
  tags = {
    Department = "QA"
    Team       = "Test"
  }
}
