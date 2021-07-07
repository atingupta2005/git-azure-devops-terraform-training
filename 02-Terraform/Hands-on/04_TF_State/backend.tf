terraform {
  backend "azurerm" {
    resource_group_name   = "myFirstResourceGroup"
    storage_account_name  = "saterraformtraining"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}