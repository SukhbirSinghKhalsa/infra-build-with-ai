variable "private_endpoints" {
  description = "Private endpoints to create."
  type = map(object({
    name                           = string
    location                       = string
    resource_group_name            = string
    subnet_id                      = string
    private_service_connection_name = string
    private_connection_resource_id = string
    subresource_names              = list(string)
    is_manual_connection            = bool
    tags                            = map(string)
  }))
}
