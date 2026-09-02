output "private_dns_zone_ids" {
  value = {
    for key, zone in azurerm_private_dns_zone.this : key => zone.id
  }
}

output "private_dns_zone_names" {
  value = {
    for key, zone in azurerm_private_dns_zone.this : key => zone.name
  }

}

output "vnet_link_ids" {
  value = {
    for key, link in azurerm_private_dns_zone_virtual_network_link.this : key => link.id
  }
}
