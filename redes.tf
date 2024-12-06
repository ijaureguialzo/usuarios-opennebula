resource "opennebula_security_group" "grupos_seguridad" {
  count = local.usuarios.numero

  name = "${local.usuarios.nombre}${local.usuarios.separador}${format("%02d", count.index+1)}"

  permissions = "640"
  group       = opennebula_group.grupos[count.index].name

  rule {
    protocol  = "ALL"
    rule_type = "OUTBOUND"
  }

  rule {
    protocol  = "ALL"
    rule_type = "INBOUND"
  }
}

resource "opennebula_virtual_network" "redes" {
  count = local.usuarios.numero

  name   = "${local.usuarios.nombre}${local.usuarios.separador}${format("%02d", count.index+1)}"
  type   = "bridge"
  bridge = "aulas"

  gateway      = local.red.puerta_enlace
  dns          = local.red.dns
  network_mask = local.red.mascara

  permissions = "640"
  group       = opennebula_group.grupos[count.index].name

  security_groups = [opennebula_security_group.grupos_seguridad[count.index].id]
}

resource "opennebula_virtual_network_address_range" "rangos_direcciones" {
  count = local.usuarios.numero

  virtual_network_id = opennebula_virtual_network.redes[count.index].id
  ar_type            = "IP4"
  size               = local.red.numero_ips
  ip4                = "172.20.${local.red.subred}.${local.red.ip_inicial+(count.index)*local.red.numero_ips}"
}
