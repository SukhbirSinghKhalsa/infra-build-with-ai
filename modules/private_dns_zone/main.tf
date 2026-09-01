resource "azurerm_private_dns_zone" "this" {
  for_each = var.private_dns_zones

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.vnet_links

  name                  = each.value.name
  resource_group_name   = var.private_dns_zones[each.value.private_dns_zone_key].resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[each.value.private_dns_zone_key].name
  virtual_network_id    = each.value.virtual_network_id
  registration_enabled  = each.value.registration_enabled
}
