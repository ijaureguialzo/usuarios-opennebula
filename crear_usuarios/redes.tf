resource "opennebula_security_group" "grupo_seguridad" {
  name = var.username

  permissions = "640"
  group       = opennebula_group.grupo.name

  rule {
    protocol  = "ALL"
    rule_type = "OUTBOUND"
  }

  rule {
    protocol  = "ALL"
    rule_type = "INBOUND"
  }
}

resource "opennebula_virtual_network" "red" {
  name   = var.username
  type   = "bridge"
  bridge = "aulas"

  gateway      = local.red.puerta_enlace
  dns          = local.red.dns
  network_mask = local.red.mascara

  permissions = "640"
  user        = opennebula_user.usuario.name
  group       = opennebula_group.grupo.name

  security_groups = [opennebula_security_group.grupo_seguridad.id]
}

resource "opennebula_virtual_network_address_range" "rango_direcciones" {
  virtual_network_id = opennebula_virtual_network.red.id
  ar_type            = "IP4"
  size               = local.red.numero_ips
  ip4                = "172.20.${local.red.subred}.${local.red.ip_inicial+(var.network)*local.red.numero_ips}"
}
