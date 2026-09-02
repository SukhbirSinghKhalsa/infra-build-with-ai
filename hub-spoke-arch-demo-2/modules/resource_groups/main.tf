resource "azurerm_resource_group" "rg1" {
  for_each = var.resource_group_map_of_object
  name     = each.value.resource_group_name
  location = each.value.location
}
