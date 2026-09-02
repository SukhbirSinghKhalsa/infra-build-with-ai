resource "azurerm_key_vault" "this" {
  for_each = var.key_vaults

  name                          = each.value.name
  location                      = each.value.location
  resource_group_name           = each.value.resource_group_name
  tenant_id                     = each.value.tenant_id
  sku_name                      = each.value.sku_name
  purge_protection_enabled      = each.value.purge_protection_enabled
  soft_delete_retention_days    = each.value.soft_delete_retention_days
  enable_rbac_authorization     = true
  public_network_access_enabled = true
  tags                          = each.value.tags
}

resource "azurerm_role_assignment" "this" {
  for_each = var.role_assignments

  scope                = azurerm_key_vault.this[each.value.key_vault_key].id
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
}

output "key_vault_ids" {
  value = {
    for key, kv in azurerm_key_vault.this : key => kv.id
  }
}

output "key_vault_names" {
  value = {
    for key, kv in azurerm_key_vault.this : key => kv.name
  }
}
