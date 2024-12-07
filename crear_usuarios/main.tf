terraform {
  required_providers {
    opennebula = {
      source  = "OpenNebula/opennebula"
      version = "~> 1.4"
    }
  }
}

provider "opennebula" {
  endpoint = "https://${local.opennebula.hostname}/RPC2"
  username = local.opennebula.username
  password = local.opennebula.token
}
