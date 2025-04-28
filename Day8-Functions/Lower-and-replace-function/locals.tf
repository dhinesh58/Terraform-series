locals {
  formatted_name = lower (replace(var.project_name," ","-"))
}