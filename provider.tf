terraform {
  backend "remote" {
    hostname     = "cps-terraform-dev.anthem.com"
    organization = "CORP"
    workspaces {
      name = "scapp1-np01-slvr3"
    }
  }
}

variable "APP_ROLE_ID" {}
variable "APP_ROLE_SECRET_ID" {}
variable "ACCOUNT_TYPE" {}
variable "VAULT_NAMESPACE" {}
variable "ATLAS_WORKSPACE_NAME" {}

provider "vault" {
  auth_login {
    path      = "auth/approle/login"
    namespace = var.VAULT_NAMESPACE
    parameters = {
      role_id   = var.APP_ROLE_ID
      secret_id = var.APP_ROLE_SECRET_ID
    }
  }
}

data "vault_aws_access_credentials" "creds" {
  backend = "aws/${var.ACCOUNT_TYPE}"
  role    = var.ACCOUNT_TYPE
  type    = "sts"
}

provider "aws" {
  default_tags {
    tags = {
      workspace = var.ATLAS_WORKSPACE_NAME
    }
  }
  region     = "us-east-2"
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
  token      = data.vault_aws_access_credentials.creds.security_token
}
