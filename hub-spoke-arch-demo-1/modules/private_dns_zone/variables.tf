variable "private_dns_zones" {
  description = "Private DNS zones to create."
  type = map(object({
    name                = string
    resource_group_name = string
    tags                = map(string)
  }))
}

variable "vnet_links" {
  description = "Private DNS zone to VNet links."
  type = map(object({
    name                  = string
    private_dns_zone_key  = string
    virtual_network_id    = string
    registration_enabled  = bool
  }))
}
