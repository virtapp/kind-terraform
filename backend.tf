###-backend

provider "aws" {}

terraform {
  backend "s3" {
    bucket               = "local-cluster"
    key                  = "terraform.tfstate"
    workspace_key_prefix = "kind-template"
    region               = "eu-west-1"
  }
}
