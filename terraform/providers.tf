terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.38.1"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

locals {
  sp = jsondecode(                              
         file(                                   
           pathexpand("~/.azure/sp.json")        
         )
       )
}

provider "azurerm" {
  features {}
  subscription_id = local.sp.subscriptionId
  tenant_id       = local.sp.tenant
  client_id       = local.sp.appId          
  client_secret   = local.sp.password       
}