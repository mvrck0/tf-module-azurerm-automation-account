locals {
  deployment_name = "TFAutomationAccount"
  template_parameters = jsonencode({
    accountName = {
      value = var.name
    },
    publicNetworkAccess = {
      value = var.public_network_access
    },
    tags = {
      value = var.tags
    }
  })
  template_content = file("${path.module}/deploy.json")
  deployment_hash  = md5("${local.template_parameters}${local.template_content}")
}

#-------------------------------------------------------------------------
# Deploy automation account using ARM-template
#-------------------------------------------------------------------------
resource "azurerm_resource_group_template_deployment" "aa" {
  name                = var.deployment_name
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  parameters_content = local.template_parameters
  template_content   = local.template_content
}

#-------------------------------------------------------------------------
# Variables
#-------------------------------------------------------------------------
variable "name" {
  type = string
  description = "The name of the automation account"
}

variable "resource_group_name" {
  type = string
  description = "The name of an existing resource group"
}

variable "public_network_access" {
  type = bool
  description = "public_network_access"
  default = true
}

variable "tags" {
  type = map(string)
  default = {
    "managed_by" = "Terraform"
  }
}

variable "deployment_name" {
  type = string
  description = "The deployment-name that will appear on the resourcegroup in azure"
  default = "TFAutomationAccount"
}

#-------------------------------------------------------------------------
# Outputs
#-------------------------------------------------------------------------
locals {
  aa = jsondecode(azurerm_resource_group_template_deployment.aa.output_content).automationAccount.value
}

output "automation_account" {
  value = local.aa
}

output "id" {
  value = "/subscriptions/${local.aa.subscriptionId}/resourceGroups/${local.aa.resourceGroupName}/providers/${local.aa.resourceId}"
}

output "name" {
  value = var.account_name
}

output "resource_group_name" {
  value = local.aa.resourceGroupName
}

output "principal_id" {
  value = local.aa.identity.principalId
}