terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-rg"
<<<<<<< HEAD
    storage_account_name  = "terraformrg145231456"
=======
    storage_account_name  = "terraformrg145231457"
>>>>>>> am1
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}