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

#Email Address
variable "email" {
  type    = string
  default = "rdhinesh58@gmail.com"
}
#Mertic Name space 
variable "metric_namespace" {
  type = string
}

#Mertic Name
variable "metric_name" {
  type = string
}
