module "resource_group" {
  for_each = {
    primary = {
      name     = "rg-azure-infra-dev"
      location = var.location
      tags = {
        environment = var.environment
        managed_by  = "terraform"
      }
    }
  }

  source = "../../modules/resource_group"

  resource_groups = {
    (each.key) = each.value
  }
}

module "networking" {
  for_each = {
    primary = {
      resource_group_name = module.resource_group["primary"].resource_group_names["primary"]
      location            = var.location
      address_space       = ["10.10.0.0/16"]
    }
  }

  source = "../../modules/networking"

  virtual_networks = {
    main = {
      name                = "vnet-azure-infra-dev"
      location            = each.value.location
      resource_group_name = each.value.resource_group_name
      address_space       = each.value.address_space
      tags = {
        environment = var.environment
        managed_by  = "terraform"
      }
    }
  }

  subnets = {
    private_endpoint = {
      name             = "snet-private-endpoint"
      address_prefixes = ["10.10.0.1.0/24"]
      vnet_key         = "main"
    }
    workload = {
      name             = "snet-workload"
      address_prefixes = ["10.10.0.2.0/24"]
      vnet_key         = "main"
    }
  }
}

module "private_dns_zone" {
  for_each = {
    primary = {
      resource_group_name = module.resource_group["primary"].resource_group_names["primary"]
      vnet_id             = module.networking["primary"].vnet_ids["main"]
    }
  }

  source = "../../modules/private_dns_zone"

  private_dns_zones = {
    keyvault = {
      name                = "privatelink.vaultcore.azure.net"
      resource_group_name = each.value.resource_group_name
      tags = {
        environment = var.environment
        managed_by  = "terraform"
      }
    }
  }

  vnet_links = {
    keyvault = {
      name                 = "link-keyvault"
      private_dns_zone_key = "keyvault"
      virtual_network_id   = each.value.vnet_id
      registration_enabled = false
    }
  }
}

module "key_vault" {
  for_each = {
    primary = {
      resource_group_name = module.resource_group["primary"].resource_group_names["primary"]
    }
  }

  source = "../../modules/key_vault"

  key_vaults = {
    primary = {
      name                       = "kv-azure-infra-dev-001"
      location                   = var.location
      resource_group_name        = each.value.resource_group_name
      tenant_id                  = var.tenant_id
      sku_name                   = "standard"
      purge_protection_enabled   = false
      soft_delete_retention_days = 7
      tags = {
        environment = var.environment
        managed_by  = "terraform"
      }
    }
  }
}

module "dns_zone" {
  for_each = {
    primary = {
      resource_group_name = module.resource_group["primary"].resource_group_names["primary"]
    }
  }

  source = "../../modules/dns_zone"

  dns_zones = {
    primary = {
      name                = "example-dev.com"
      resource_group_name = each.value.resource_group_name
      tags = {
        environment = var.environment
        managed_by  = "terraform"
      }
    }
  }
}

output "resource_group_ids" {
  value = {
    for key, module_instance in module.resource_group : key => module_instance.resource_group_ids
  }
}

output "vnet_ids" {
  value = {
    for key, module_instance in module.networking : key => module_instance.vnet_ids
  }
}

output "subnet_ids" {
  value = {
    for key, module_instance in module.networking : key => module_instance.subnet_ids
  }
}

output "key_vault_ids" {
  value = {
    for key, module_instance in module.key_vault : key => module_instance.key_vault_ids
  }
}

output "dns_zone_ids" {
  value = {
    for key, module_instance in module.dns_zone : key => module_instance.dns_zone_ids
  }
}
