#Can use terraform console to play around with various functions
provider "aws" {
}

locals {
  time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

variable "region" {
  default = "ap-south-1"
}

variable "tags" {
  type = list
  default = ["firstec2","secondec2"]
}

variable "itype" {
  type = map
  default = {
    "us-east-1" = "t2.micro"
    "us-west-2" = "t2.nano"
    "ap-south-1" = "t2.small"
  }
}

# How to generate rsa
#ssh-keygen  -f ./id_rsa
resource "aws_key_pair" "loginkey" {
  key_name   = "login-key"
  public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_instance" "app-dev" {
   # Retrieves a value of a single element from a map given its key.
   # lookup(map, key, default value)
   ami = "ami-082b5a644766e0e6f"
   instance_type = lookup(var.itype,var.region)
   key_name = aws_key_pair.loginkey.key_name
   count = 2

   tags = {
     Name = element(var.tags,count.index)
   }
}


output "timestamp" {
  value = local.time
}