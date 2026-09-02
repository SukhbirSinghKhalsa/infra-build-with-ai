variable "virtual_networks" {
  description = "Virtual networks to create."
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = map(string)
  }))
}

variable "subnets" {
  description = "Subnets to create, keyed by subnet name."
  type = map(object({
    name             = string
    address_prefixes = list(string)
    vnet_key          = string
  }))
}
