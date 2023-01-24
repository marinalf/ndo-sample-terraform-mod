# Define the provider source

terraform {
  required_providers {
    mso = {
      source  = "CiscoDevNet/mso"
      version = ">= 0.7.1"
    }
  }
}
