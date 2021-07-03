# Terraform Useful Commands

Version Number Arguments | Description  
------- | ----------------  
\>=2.0 | Greater than or equal to version 2.0  
<=3.0 | Less than or equal to version 3.0  
~>3.0 | Any version in the 3.0 range  
\>=3.10,<=3.18 | Any version between 3.10 and 3.18  

## Alias
```bash
alias tf=terraform
```

## Terraform Console
```bash
echo "Atin Gupta" > myfile.txt
tf console      # access interactive command-line console to experiment with expressions

> "${file("myfile.txt")}"
> 1+5
> length(list("hello", "world"))
> lookup(map("id", "1","message", "hello world" ), "id")
> lookup(map("id", "1","message", "hello world" ), "message")
> lookup(map("id", "1","message", "hello world" ), "author", "None")
> length(list("hello", "world"))
> exit

```

## Terraform Validate
```bash
tf validate     # validate the configuration for syntax validity
```

## Terraform Format
```bash
tf fmt      # format the configuration files to standardize style
```

## Terraform Init
```bash
tf init      # initialize terraform config files

tf init -upgrade        # upgrade to the latest provider 
```

## Envrionment Variable
```bash
setx TF_VAR_instancetype m5.large       # set a variable via environment variable (Windows)

export TF_VAR_instancetype="t2.nano"        # set a variable via environment variable (Linux)
```

## Terraform Get
```bash
tf get      # install and update modules
```

## Terraform Plan
```bash
tf plan     # pre-deployment plan

tf plan -out=newplan    # save the plan to a file

tf plan -var="instancetype=t2.small"        # explicitly define variable value

tf plan -var-file="custom.tfvars"       # use custom tfvars file name

tf plan -target aws_security_group.sg_allow_ssh     # detect changes in a specific resource

tf plan -refresh=false      # skip the refresh of all resources in the configuration

tf plan -destroy        # plan a destroy without committing
```

## Terraform Apply
```bash
tf apply    # prompt before creating resources described in tf

tf apply --auto-approve     # create resources without prompt

tf apply "newplan"      # apply plan from plan file
```

## Terraform Destroy
```bash
tf destroy      # destroy all

tf destroy -target aws_instace.my_instance      # only destroy specific resource
```

## Terraform Taint
```bash
tf taint aws_instance.myec2     # mark ec2 instance to destroy and recreate on next apply
```

## Terraform State
```bash
tf state show aws_eip.myeip    # inspect the state of an elastic ip resource

tf state list   # list the resources in the state file

tf state refresh      # refresh the current state

```

## Terraform Graph
```bash
tf graph    # visual dependency graph
```

## Terraform Output
```bash
tf output iam_arm       # output the value iam_arn specified within the output configuration
```


## Count and Count Index
```hcl
/* 
if the environment variable is equal to "prod"
then create 0(none), else create 1
*/
count = var.environment == "production" ? 0 : 1

/*
if the environment variable is equal to "prod"
then set allocation method to "static", else set to "Dynamic"
*/
allocation_method = var.environment == "prod" ? "static" : "Dynamic"
```
```hcl
# main.tf

# create 5 ec2 instances
resource "aws_instance" "instance_one" {
    ami = "ami082c5a44755e0e6f"
    instance_type = "t2.micro"
    count = 5
}
```
```hcl
# main.tf

# create 5 users, appending the count index (0-4) for each
resource "aws_iam_user" "iam_user" {
    name = "ec2user.${count.index}"
    count = 5
}
```
```hcl
# main.tf

# iterate through the index of variable names
variable "ec2_names" {
    type = list
    default = ["dev-ec2user", "stage-ec2user", "prod-ec2user"]
}

resource "aws_iam_user" "iam_user" {
    name = var.ec2_names[count.index]
    count = 3
}
```
```hcl
# main.tf

# create a dev ec2 instance or prod ec2 instance
variable "dev_env" {}

resource "aws_instance" "instance_one" {
    ami = "ami082c5a44755e0e6f"
    instance_type = "t2.micro"
    count = var.dev_env == true ? 1 : 0
}

resource "aws_instance" "instance_one" {
    ami = "ami082c5a44755e0e6f"
    instance_type = "t2.large"
    count = var.dev_env == false ? 1: 0
}
```


## Logging
```bash
export TF_LOG=TRACE     # enable trace logging

export TF_LOG_PATH="terraform.txt"      # set log path to output to a file
```

## Comments
```hcl
/*
resource "digitalocean_droplet" "my_droplet" {
    image = "ubuntu-18-04-x64"
    name = "web-1"
    region = "nyc1"
    size = "s-1vcpu-1gb"
}
*/
```


## Fetch Data from Map
```hcl
# main.tf
resource "aws_instance" "myec2" {
    ami = "ami082c5a44755e0e6f"
    instance_type = var.types["us-west-2"]
}

variable "types" {
    type = map
    default = {
        us-east-1 = "t2.micro"
        us-west-2 = "t2.nano"
        ap-south-1 = "t2.small"
    }
}
```

## Fetch Data from List
```hcl
# main.tf
resource "aws_instance" "myec2" {
    ami = "ami082c5a44755e0e6f"
    instance_type = var.types[0]
}

variable "types" {
    type = list
    default = ["m5.large","m5.xlarge","t2.medium"]
}
```

## Locals 
```hcl
# main.tf

locals {
  common_tags = {
    Owner = "DevOps Team"
    service = "backend"
  }
}
resource "aws_instance" "app-dev" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
   tags = local.common_tags
}

resource "aws_ebs_volume" "db_ebs" {
  availability_zone = "us-west-2a"
  size              = 8
  tags = local.common_tags
}
```
```hcl
# main.tf

variable "name" {}

variable "default" {}

locals {
    name_prefix = "${var.name != "" ? var.name : var.default}"
}

resource "aws_instance" "app-dev" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
   name = local.name_prefix
}
```

## Functions
```hcl
# main.tf

variable "region" {
    default = "us-east-1"
}

variable "ami" {
    type = map
    default = {
        "us-east-1" = "ami-0323c3dd2da7fb37d"
        "us-west-2" = "ami-0d6621c01e8c2de2c"
        "ap-south-1" = "ami-0470e33cd681b2476"
    }
}

variable "tags" {
    type = list
    default = ["firstec2","secondec2"]
}

# use the file function to use the public key from id_rsa.pub in the module path
/*Path information
The syntax is path.<TYPE>. TYPE can be cwd, module, or root. cwd will interpolate the current working directory. module will interpolate the path to the current module. root will interpolate the path of the root module. In general, you probably want the path.module variable.
*/
resource "aws_key_pair" "loginkey" {
  key_name   = "login-key"
  public_key = file("${path.module}/id_rsa.pub")
}

# use the lookup function to insert ami ID
# use the element function to interate through tags for each instance count
resource "aws_instance" "app-dev" {
   ami = lookup(var.ami,var.region)
   instance_type = "t2.micro"
   key_name = aws_key_pair.loginkey.key_name
   count = 2

   tags = {
     Name = element(var.tags,count.index)
   }
}
```

## Data Sources
```hcl
# main.tf

# retrieve the correct ami for the ap-southeast-1 region
provider "aws" {
  region     = "ap-southeast-1"
}

data "aws_ami" "my_ami" {
  most_recent = true
  owners = ["amazon"]


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "instance-1" {
    ami = data.aws_ami.my_ami.id
   instance_type = "t2.micro"
}
```

## Dynamic Block
```hcl
# main.tf

# dynamically create multiple security group rules for each port
# the iterator reassigns the element name
variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [8200, 8201,8300, 9200, 9500]
}

resource "aws_security_group" "dynamicsg" {
  name        = "dynamic-sg"
  description = "Ingress for Vault"

  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.sg_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

## Splat Expression
```
# main.tf

# output the ARN for all 3 users
resource "aws_iam_user" "ec2_user" {
  name = "iamuser.${count.index}"
  count = 3
  path = "/system/"
}

output "arns" {
  value = aws_iam_user.ec2_user[*].arn
}
```

## Provisioner
```hcl
# main.tf

# create ec2 instance and use remote-exec to ssh into the instance and install nginx
resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
   key_name = "mykey"

   provisioner "remote-exec" {
     inline = [
       "sudo amazon-linux-extras install -y nginx1.12",
       "sudo systemctl start nginx"
     ]

   connection {
     type = "ssh"
     user = "ec2-user"
     private_key = file("~/mykey.txt")
     host = self.public_ip
   }
   }
}
```
```hcl
# main.tf

# create ec2 instance and use local exec to copy private ip to a file
resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"

   provisioner "local-exec" {
    command = "echo ${aws_instance.myec2.private_ip} >> private_ips.txt"
  }
}
```
