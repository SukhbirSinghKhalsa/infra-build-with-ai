variable "key_vaults" {
  description = "Key Vaults to create."
  type = map(object({
    name                       = string
    location                   = string
    resource_group_name        = string
    tenant_id                  = string
    sku_name                   = string
    purge_protection_enabled   = bool
    soft_delete_retention_days = number
    tags                       = map(string)
  }))
}

variable "role_assignments" {
  description = "RBAC role assignments for Key Vaults."
  type = map(object({
    key_vault_key = string
    principal_id   = string
    role_definition_name = string
  }))
  default = {}
}
