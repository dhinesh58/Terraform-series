
variable "vm_sizes" {
    type = map(string)
    default = {
    dev     = "standard_D2s_v3",
    staging = "standard_D4s_v3",
    prod    = "standard_D8s_v3"
    }
  
}



variable "vm_size" {
    type = string
    default = "standard_D2s_v3"
    validation {
      condition = length(var.vm_size) >=2 && length(var.vm_size)<= 20
      error_message = "The vm_size should be between 2 and 20 chars"
    }
    validation {
      condition = strcontains(lower(var.vm_size),"standard")
      error_message = "The vm size should contains standard"
    }
  
}