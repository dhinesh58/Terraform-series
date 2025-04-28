#Create variable for Resource group name
variable "RG_Name" {
  type        = string
  description = "Resource group name "
}

# Create Variable for Resource group location 
variable "location" {
  type        = string
  description = "Location details "
}

# Create variable for address space 
variable "address_space" {
  description = "address range"
}

# Create variable for address prefixes 
variable "address_prefixes" {
  description = "address prefixes"
}
