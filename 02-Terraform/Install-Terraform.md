# Install Terraform

## For Linux - Ubuntu
```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt-get update && sudo apt-get install terraform

terraform -help

terraform -install-autocomplete
```

## For Windows
 - https://releases.hashicorp.com/terraform/0.13.4/terraform_0.13.4_windows_amd64.zip


## Export Terraform Secret Keys (Optional)
```
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_DEFAULT_REGION="us-west-2"
```