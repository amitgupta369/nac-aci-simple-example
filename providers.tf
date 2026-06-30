terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">= 2.20.0"
    }

    utils = {
      source  = "netascode/utils"
      version = "2.0.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">= 2.9.0"
    }
  }
}

provider "aci" {
  username = var.apic_username
  password = var.apic_password
  url      = var.apic_url
  insecure = true
}
