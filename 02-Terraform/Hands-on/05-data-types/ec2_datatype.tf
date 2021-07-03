provider "aws" {
}

resource "aws_iam_user" "lb" {
  name = var.usernumber
  path = "/system/"
}