data "opennebula_datastore" "default" {
  name = "default"
}

resource "opennebula_user_quotas" "cuota_datastore" {
  user_id = opennebula_user.usuario.id

  datastore {
    id   = data.opennebula_datastore.default.id
    size = local.cuota.disco_imagenes * 1024
  }
}

resource "opennebula_user_quotas" "cuota_sistema" {
  user_id = opennebula_user.usuario.id

  vm {
    running_cpu      = local.cuota.cpu
    running_memory   = local.cuota.memoria * 1024
    system_disk_size = local.cuota.disco_sistema * 1024
  }
}
