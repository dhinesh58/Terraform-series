# using list constraints for slecting names
# variable "azurerm_resource_group_name" {
# type = list(string)
# default = [ "Test-TG" , "Test2-RG"]
# }

# Using set (list) constraints for slecting names
variable "azurerm_resource_group_name" {
  type = set(string)
  default = [ "DEV-TG" , "PROD-RG" ]
}
