resource "opennebula_group" "grupos" {
  count = local.usuarios.numero

  name = "${local.usuarios.nombre}${local.usuarios.separador}${format("%02d", count.index+1)}"

  sunstone {
    views        = "cloud, user"
    default_view = "user"
  }
}

resource "null_resource" "borrar_default_vdc_grupo" {
  count = local.usuarios.numero

  connection {
    type = "ssh"
    user = "root"
    private_key = file("/root/.ssh/id_rsa")
    host = local.opennebula.hostname
  }

  provisioner "remote-exec" {
    inline = [
      "onevdc delgroup default ${opennebula_group.grupos[count.index].name}"
    ]
  }
}


resource "opennebula_user" "usuarios" {
  count = local.usuarios.numero

  name          = "${local.usuarios.nombre}${local.usuarios.separador}${format("%02d", count.index+1)}"
  password      = local.usuarios.password
  auth_driver   = "core"
  primary_group = opennebula_group.grupos[count.index].id

  lifecycle {
    ignore_changes = [
      quotas
    ]
  }
}
