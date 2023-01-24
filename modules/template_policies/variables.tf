
# AWS credentials

variable "aws" {
  type = object({
    aws_account_id = string
  })
  default = {
    aws_account_id = "account"
  }
}

# Azure credentials

variable "azure" {
  type = object({
    azure_subscription_id = string
  })
  default = {
    azure_subscription_id = "subscription"
  }
}

# Sites, Schema & Templates

variable "cloudsite1_id" {
  description = "azure"
}

variable "cloudsite2_id" {
  description = "aws"
}

variable "schema_id" {
  description = "Schema ID"
}

variable "template_name" {
  description = "template name"
}

# Logical Configuration

variable "vrf_name" {
  type    = string
  default = "vrf1"
}

## Site Level - Networking

# AWS Networking Config

variable "aws_region_name" {
  type    = string
  default = "eu-west-2"
}

variable "tgw_name" {
  type    = string
  default = "TGW" # This is the TGW name configured during initial CNC setup
}

variable "aws_cidr_ip" {
  type    = string
  default = "10.1.0.0/16"
}

variable "aws_tgw_subnets" {
  type = map(object({
    name = string
    ip   = string
    zone = string
  }))
  default = {
    tgw-a-subnet = {
      name  = "tgw-a-subnet"
      ip    = "10.1.1.0/24"
      zone  = "eu-west-2a"
      usage = "gateway"
    },
    tgw-b-subnet = {
      name  = "tgw-b-subnet"
      ip    = "10.1.2.0/24"
      zone  = "eu-west-2b"
      usage = "gateway"
    }
  }
}

variable "aws_user_subnets" {
  type = map(object({
    name = string
    ip   = string
    zone = string
  }))
  default = {
    web-subnet = {
      name  = "web-subnet"
      ip    = "10.1.3.0/24"
      zone  = "eu-west-2a"
      usage = "user"
    },
    db-subnet = {
      name  = "db-subnet"
      ip    = "10.1.4.0/24"
      zone  = "eu-west-2b"
      usage = "user"
    }
  }
}

# Azure Networking Config

variable "azure_region_name" {
  type    = string
  default = "uksouth"
}

variable "azure_cidr_ip" {
  type    = string
  default = "20.1.0.0/16"
}

variable "user_subnets" {
  type = map(object({
    name = string
    ip   = string
  }))
  default = {
    web-subnet = {
      name = "web-subnet"
      ip   = "20.1.3.0/24"
    },
    db-subnet = {
      name = "db-subnet"
      ip   = "20.1.4.0/24"
    }
  }
}


