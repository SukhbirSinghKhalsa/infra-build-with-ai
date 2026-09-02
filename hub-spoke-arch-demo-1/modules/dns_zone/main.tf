resource "azurerm_dns_zone" "this" {
  for_each = var.dns_zones

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags
}

output "dns_zone_ids" {
  value = {
    for key, zone in azurerm_dns_zone.this : key => zone.id
  }
}

output "dns_zone_names" {
  value = {
    for key, zone in azurerm_dns_zone.this : key => zone.name
  }
}
