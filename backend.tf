terraform {
  required_version = ">= 1.8.0"
  cloud {
    organization = "amitgupta-lab"
    workspaces {
      name = "aci-devnet-lab"
    }
  }
}
