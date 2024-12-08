resource "opennebula_group" "grupo" {
  name = var.username

  sunstone {
    views        = "user"
    default_view = "user"
  }
}

resource "opennebula_user" "usuario" {
  name          = var.username
  password      = var.password
  auth_driver   = "core"
  primary_group = opennebula_group.grupo.id

  lifecycle {
    ignore_changes = [
      quotas,
      ssh_public_key,
    ]
  }
}
