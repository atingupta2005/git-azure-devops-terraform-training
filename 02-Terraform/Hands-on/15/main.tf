terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}


data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_storage_account" "storage" {
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.rg.name
}


resource "azurerm_storage_container" "container" {
  name                  = var.storage_container_name
  storage_account_name  = data.azurerm_storage_account.storage.name
  container_access_type = "container" # "blob" "private"
}

resource "azurerm_storage_blob" "blob" {
  name                   = "sample-file.sh"
  storage_account_name   = data.azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source                 = "commands.sh"
}
