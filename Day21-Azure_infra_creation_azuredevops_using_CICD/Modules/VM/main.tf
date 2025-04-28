#Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "name" {
resource_group_name = var.azurerm_resource_group_name.n
}
