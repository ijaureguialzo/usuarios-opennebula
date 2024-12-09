resource "opennebula_virtual_data_center" "datacenter" {
  name = var.username

  group_ids = [opennebula_group.grupo.id]

  zones {
    id = 0
    host_ids = [0]
    datastore_ids = [0, 1, 2]
    vnet_ids = var.crear_red ? [opennebula_virtual_network.red[0].id] : []
  }
}

resource "null_resource" "borrar_default_vdc_grupo" {
  connection {
    type = "ssh"
    user = "root"
    private_key = file("/root/.ssh/id_rsa")
    host = var.hostname
  }

  provisioner "remote-exec" {
    inline = [
      "onevdc delgroup default ${opennebula_group.grupo.name}"
    ]
  }
}
