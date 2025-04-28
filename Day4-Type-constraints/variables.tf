variable "name" {
  type = string
  description = "Value for the Name "
  default = "Dev"
}

# using list constraints for slecting locations
variable "allowed_locations" {
  type = list(string)
  description = "value for the locations"
  default = [ "centralindia" , "southindia" , "eastus" ]
}

# Using Tuple type for IP addresss 
variable "address_space" {
  type = tuple([ string,string,number ])
  description = "VNET address, subnet address, subnet mask"
  default = ["10.0.0.0/16", "10.0.2.0" ,24]
}

# Using List type constraints for VM Size
variable "vm_size" {
  type = list(string)
  description = "value for the allowed VMs"
  default = [ "Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2" ]
  
}

# Using Boolean type constraints for delete the vm os disk after  termination
variable "is_delete" {
  type = bool
  description = "delete the vm os disk after termination"
  default = true
}

# using object type constraints for Image source references 
variable "Image" {
    type = object({
    publisher = string
    offer = string
    sku = string
    version = string
  })
  description = "value"
  default = {
    publisher    = "Canonical"
    offer        = "0001-com-ubuntu-server-jammy"
    sku          = "22_04-lts"
    version      = "latest"
  }
}

# using number type for OS disk size
variable "storage_disk" {
    type = number
    description = "the storage disk size of os"
    default = 80
  
}