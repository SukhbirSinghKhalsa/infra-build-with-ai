output "vnet_ids" {
  value = {
    for key, vnet in azurerm_virtual_network.this : key => vnet.id
  }
}

output "vnet_names" {
  value = {
    for key, vnet in azurerm_virtual_network.this : key => vnet.name
  }
}

output "subnet_ids" {
  value = {
    for key, subnet in azurerm_subnet.this : key => subnet.id
  }
}

output "subnet_names" {
  value = {
    for key, subnet in azurerm_subnet.this : key => subnet.name
  }
}
