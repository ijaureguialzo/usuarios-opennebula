resource "opennebula_virtual_data_center" "datacenter" {
  count = local.usuarios.numero

  name = "${local.usuarios.nombre}${local.usuarios.separador}${format("%02d", count.index+1)}"

  group_ids = [opennebula_group.grupos[count.index].id]

  zones {
    id = 0
    host_ids = [0]
    datastore_ids = [0, 1, 2]
    vnet_ids = [opennebula_virtual_network.redes[count.index].id]
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
