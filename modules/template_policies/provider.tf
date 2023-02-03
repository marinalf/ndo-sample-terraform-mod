# Define the provider source

terraform {
  required_providers {
    mso = {
      source  = "CiscoDevNet/mso"
      version = ">= 0.8.1"
    }
  }
}
