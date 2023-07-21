provider "aws" {
  region = "eu-central-1"

  access_key = var.access_key
  secret_key = var.secret_key
}

provider "aws" {
  alias = "us_east_1"
  region = "us-east-1"

  access_key = var.access_key
  secret_key = var.secret_key
}

/* provider "argocd" {
  server_addr = local.argocd_host
  # auth_token  = var.argocd_auth_token
  username = var.argocd_username
  password = var.argocd_password
} */