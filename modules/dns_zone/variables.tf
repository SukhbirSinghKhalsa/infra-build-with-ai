variable "dns_zones" {
  description = "Public DNS zones to create."
  type = map(object({
    name                = string
    resource_group_name = string
    tags                = map(string)
  }))
}
