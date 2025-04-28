#Montor Action group 
resource "azurerm_monitor_action_group" "MT" {
  name                = "example-actiongroup"
  resource_group_name = azurerm_resource_group.RG.name
  short_name          = "exampleact"

  email_receiver {
    name          = "send to email"
    email_address = var.email
  }
}
resource "azurerm_monitor_metric_alert" "name" {
  name                = "metric-alert"
  resource_group_name = azurerm_resource_group.RG.name
  scopes              = [azurerm_linux_virtual_machine.myVM.id]
  description         = "Action will be triggered when CPU is greater than 60."

  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = var.metric_name
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 60
  }

  action {
    action_group_id = azurerm_monitor_action_group.MT.id
  }
}


#Memory Disk Alert 
resource "azurerm_monitor_metric_alert" "disk" {
  name                = "disk-alert"
  resource_group_name = azurerm_resource_group.RG.name
  scopes              = [azurerm_linux_virtual_machine.myVM.id]
  description         = "Action will be triggered when Free disk space is less than 20."

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Available Memory Bytes"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 20
  }

  action {
    action_group_id = azurerm_monitor_action_group.MT.id
  }
}
