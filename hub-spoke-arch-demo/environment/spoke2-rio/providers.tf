terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.26.0"
    }
  }
#   backend "azurerm" {
#     resource_group_name = "rg-prod-001"
#     storage_account_name = "stgprodbackend001"
#     container_name = "container001"
#     key= "sandbox.terraform.tfstate"
#   }
}

provider "azurerm" {
  features {  }
#   subscription_id = "81ecb27a-3e2a-4767-845c-754b5dd489ab"
}