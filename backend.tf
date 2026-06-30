terraform {
  cloud {
    organization = "amitgupta-lab"
    workspaces {
      name = "aci-devnet-lab"
    }
  }
}
