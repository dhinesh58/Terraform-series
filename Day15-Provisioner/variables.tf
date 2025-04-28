# RG Name 
variable "RG_name" {
  type        = string
  description = "RG name "
}

# Location
variable "Location" {
  type        = string
  description = "Resource Location"
}

#Vnet Name
variable "Vnet_Name" {
  type        = string
  description = "Vnet Name"
}

#Subnet Name
variable "Subnet_Name" {
  type        = string
  description = "value"
}

variable "Vnet_address_space" {
  description = "value"
}

variable "address_prefixes" {
  description = "address_prefixes"
}

# Public IP address Name 
variable "PublicIP_Name" {
}

#VM Name
variable "VM_Name" {
  type        = string
  description = "VM Name "
}

#VM Size
variable "VM_size" {
  
}