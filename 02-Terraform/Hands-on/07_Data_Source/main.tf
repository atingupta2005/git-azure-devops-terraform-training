terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "my_rg" {
  name = "app-0"
}

resource "random_integer" "demo07_random_number" {
  min = 1000
  max = 100000
}


resource "azurerm_storage_account" "my_st" {
  name                     = "atinsajulyy21${random_integer.demo07_random_number.result}"
  resource_group_name      = data.azurerm_resource_group.my_rg.name
  location                 = data.azurerm_resource_group.my_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = data.azurerm_resource_group.my_rg.tags
}

output "my_rg" {
  value = data.azurerm_resource_group.my_rg.name
}


#data "azurerm_virtual_network" "example" {
#  name                = "LukeLab-NC-Prod-Vnet"
#  resource_group_name = "NetworkingTest-RG"
#}

#output "subnets" {
#  value = [for s in data.azurerm_virtual_network.example.subnets : lower(s)]
#}
