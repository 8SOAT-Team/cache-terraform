terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ACG-Terraform-Labs-Teste"

    workspaces {
      name = "techchallenge-cache" 
    }
  }
}

provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
}
