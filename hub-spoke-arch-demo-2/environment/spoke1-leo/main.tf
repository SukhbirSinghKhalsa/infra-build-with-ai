variable "resource_group_map_of_object" {}
module "rg" {
    source = "../../modules/resource_groups"
    resource_group_map_of_object = var.resource_group_map_of_object
}