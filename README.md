# TF Module Azurerm AutomationAccount

A terraform module that adds identity features to azurerm_automation account using the 2020-01-13-preview api from Azure RM.

## Basic example
```hcl
module "automation-account" {
  source = "https://github.com/mvrck0/tf-module-azurerm-automation-account.git?ref=master"
  name = "example-automation-account"
  sku = "Basic"
  tags = {
    environment = "development"
  }
}


data "azurerm_automation_account" "aa" {
  name                = jsondecode(azurerm_ resource_group_template_deployment.aa.output_content).accountName.value
  resource_group_name = data.azurerm_resource_group.rg.name
}

```

# Variables


# Outputs 