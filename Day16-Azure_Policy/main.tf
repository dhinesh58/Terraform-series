#Subscription 
data "azurerm_subscription" "current" {

}

output "Subscription" {
    value = data.azurerm_subscription.current.id
  
}

# Assign policy for Tags
resource "azurerm_policy_definition" "Tags" {
  name         = "Tags"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Assigned Tags policy"
  policy_rule = jsonencode({
    if = {
      anyOf = [
        {
          field  = "tags[${var.Tags[0]}]",
          exists = false
        },
        {
          field  = "tags[${var.Tags[1]}]",
          exists = false
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })


}

resource "azurerm_subscription_policy_assignment" "name" {
  name                 = "Tag-assignment"
  policy_definition_id = azurerm_policy_definition.Tags.id
  subscription_id      = data.azurerm_subscription.current.id

}
