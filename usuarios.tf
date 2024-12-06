resource "opennebula_group" "grupos" {
  count = local.usuarios.numero

  name = "${local.usuarios.nombre}${local.usuarios.separador}${format("%02d", count.index+1)}"

  template_section {
    name = "SUNSTONE"
    elements = {
      VIEWS                    = "cloud, user"
      DEFAULT_VIEW             = "user"
      GROUP_ADMIN_VIEWS        = "groupadmin"
      GROUP_ADMIN_DEFAULT_VIEW = "groupadmin"
    }
  }
}

resource "opennebula_user" "usuarios" {
  count = local.usuarios.numero

  name          = "${local.usuarios.nombre}${local.usuarios.separador}${format("%02d", count.index+1)}"
  password      = local.usuarios.password
  auth_driver   = "core"
  primary_group = opennebula_group.grupos[count.index].id
}
