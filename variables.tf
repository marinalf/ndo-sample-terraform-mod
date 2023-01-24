#  Provider Variables

variable "ndo" {
  type = map(any)
  default = {
    username = "username"
    password = "password"
    url      = "url"
    domain   = "local"
  }
}

# Azure Variables

variable "azure" {
  type = object({
    azure_subscription_id = string
  })
  default = {
    azure_subscription_id = "subscription"
  }
}

# AWS Variables

variable "aws" {
  type = object({
    aws_account_id = string
  })
  default = {
    aws_account_id = "account"
  }
}

# Site names as seen on Nexus Dashboard

variable "azure_site_name" {
  type    = string
  default = "azure"
}

variable "aws_site_name" {
  type    = string
  default = "aws"
}
