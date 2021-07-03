

### Base Terraform Configuration (Before any modification)
```sh
provider "aws" {
}

resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
}
```
### Final Modified Terraform Configuration:
```sh
provider "aws" {
}

resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = var.instancetype
}
```
### variables.tf

```sh
variable "instancetype" {
  default = "t2.micro"
}
```
### terraform.tfvars

```sh
instancetype="t2.large"
```
## Loading Variable Values from CLI
```sh
terraform plan -var="instancetype=t2.small"
```
### Loading from custom tfvars file
```sh
terraform plan -var-file="custom.tfvars"
``` 
