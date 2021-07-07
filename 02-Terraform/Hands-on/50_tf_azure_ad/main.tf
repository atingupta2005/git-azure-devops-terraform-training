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
<<<<<<< HEAD
  user_principal_name = "ating@atinintellipaatgmail.onmicrosoft.com"
  display_name        = "Atin Gupta"
  mail_nickname       = "atingupta"
=======
  count    = 3
  user_principal_name = "ating-${count.index}@atintrainermct2gmail.onmicrosoft.com"
  display_name        = "Atin Gupta${count.index}"
  mail_nickname       = "atingupta${count.index}"
>>>>>>> am1
  password            = "Azure@123456"
}

resource "azuread_group" "group" {
  name = "MyTerraformGroup"
<<<<<<< HEAD
  members = [
    azuread_user.user.object_id,
=======
  count    = 3
  members = [
    azuread_user.user[count.index].object_id,
>>>>>>> am1
    /* more users */
  ]
}
