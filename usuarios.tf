resource "opennebula_group" "grupos" {
  count = local.usuarios.numero

  name = "${local.usuarios.nombre}${local.usuarios.separador}${format("%02d", count.index+1)}"

  sunstone {
    views        = "cloud, user"
    default_view = "user"
  }
}

resource "opennebula_user" "usuarios" {
  count = local.usuarios.numero

  name          = "${local.usuarios.nombre}${local.usuarios.separador}${format("%02d", count.index+1)}"
  password      = local.usuarios.password
  auth_driver   = "core"
  primary_group = opennebula_group.grupos[count.index].id
}
