terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "1.1.1"
    }
  }
}

provider "azuread" {
}

resource "azuread_user" "user" {
  count    = 3
  user_principal_name = "ating-${count.index}@atintrainermct2gmail.onmicrosoft.com"
  display_name        = "Atin Gupta${count.index}"
  mail_nickname       = "atingupta${count.index}"
  password            = "Azure@123456"
}

resource "azuread_group" "group" {
  name = "MyTerraformGroup"
  count    = 3
  members = [
    azuread_user.user[count.index].object_id,
    /* more users */
  ]
}
