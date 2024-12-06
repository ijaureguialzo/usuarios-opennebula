data "opennebula_datastore" "default" {
  name = "default"
}

resource "opennebula_user_quotas" "cuotas_datastore" {
  count = local.usuarios.numero

  user_id = opennebula_user.usuarios[count.index].id

  datastore {
    id   = data.opennebula_datastore.default.id
    size = local.cuota.disco_imagenes * 1024
  }
}

resource "opennebula_user_quotas" "cuotas_sistema" {
  count = local.usuarios.numero

  user_id = opennebula_user.usuarios[count.index].id

  vm {
    running_cpu      = local.cuota.cpu
    running_memory   = local.cuota.memoria * 1024
    system_disk_size = local.cuota.disco_sistema * 1024
  }
}
