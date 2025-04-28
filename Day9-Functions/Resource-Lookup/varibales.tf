variable "location" {
  type = map(string)
  default = {
  dev = "centralindia",
  pro = "westus",
  test = "eastus"
  }
}

variable "environment" {
  type = string
  description = "environment"
  validation {
    condition = contains(["dev","pro","test"],var.environment)
    error_message = "enter the valid value for env:"
  }
}