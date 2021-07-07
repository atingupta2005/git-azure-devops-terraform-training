terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-rg"
    storage_account_name  = "terraformrg145231457"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}