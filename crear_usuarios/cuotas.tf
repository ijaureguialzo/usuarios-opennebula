data "opennebula_datastore" "default" {
  name = "default"
}

resource "opennebula_user_quotas" "cuota_datastore" {
  user_id = opennebula_user.usuario.id

  datastore {
    id   = data.opennebula_datastore.default.id
    size = var.cuota.disco_imagenes * 1024
  }
}

resource "opennebula_user_quotas" "cuota_sistema" {
  user_id = opennebula_user.usuario.id

  vm {
    running_cpu      = var.cuota.cpu
    running_memory   = var.cuota.memoria * 1024
    system_disk_size = var.cuota.disco_sistema * 1024
  }
}
