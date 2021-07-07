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
  user_principal_name = "ram@facare9146nnacell.onmicrosoft.com"
  display_name        = "Ramkumar Murugesan"
  mail_nickname       = "rammur"
  password            = "Azure@123456"
}

resource "azuread_group" "group" {
  name = "MyTerraformGroup"
  members = [
    azuread_user.user.object_id,
    /* more users */
  ]
}
