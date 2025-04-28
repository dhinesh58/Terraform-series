locals {
  formatted_name = lower (replace(var.project_name," ","-"))
  merge_tags = merge(var.Testing-Tags,var.Dev_tags)
  storage_formatted = replace(replace(lower(substr(var.storage_accountname,0,23)), " ", ""),"!","")
}