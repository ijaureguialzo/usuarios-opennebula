resource "opennebula_virtual_data_center" "datacenter" {
  count = local.usuarios.numero

  name = "${local.usuarios.nombre}${local.usuarios.separador}${format("%02d", count.index+1)}"

  group_ids = [opennebula_group.grupos[count.index].id]
}
