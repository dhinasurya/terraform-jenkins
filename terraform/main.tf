resource "azurerm_resource_group" "rare_rg" {
  name     = var.resource_group_name
  location = var.location
}