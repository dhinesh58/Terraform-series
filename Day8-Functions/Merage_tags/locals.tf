locals {
  formatted_name = lower (replace(var.project_name," ","-"))
  merge_tags = merge(var.Testing-Tags,var.Dev_tags)
}