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
  subscription_id = "55436b1b-53cc-455c-a96a-0567fbbe7697"
}


resource "azurerm_resource_group" "rgTFJuly" {
  name     = "rgTFJuly"
  location = "West Europe"
}

resource "azurerm_storage_account" "satfjuly21" {
  name                     = "satfjuly21"
  resource_group_name      = azurerm_resource_group.rgTFJuly.name
  location                 = azurerm_resource_group.rgTFJuly.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "input" {
  name                  = "input"
  storage_account_name  = azurerm_storage_account.satfjuly21.name
  container_access_type = "private"
}
