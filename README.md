# TF Module Azurerm AutomationAccount

A terraform module that adds identity features to azurerm_automation account using the 2020-01-13-preview api from Azure RM.

## Basic example
```hcl
module "aa" {
  source = "git::https://github.com/mvrck0/tf-module-azurerm-automation-account.git?ref=main"
  name   = "example-automation-account"
  sku    = "Basic"
  tags = {
    environment = "development"
  }
}


data "azurerm_automation_account" "aa" {
  name                = module.aa.name
  resource_group_name = module.aa.resource_group_name
}

output "automation_account_id" {
  value = module.aa.id
}

output "aa" {
  value = data.azurerm_automation_account.aa
}
```

# Variables


# Outputs 