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
  type   = "fw"
  bridge = "aulas"

  gateway      = var.red.puerta_enlace
  dns          = var.red.dns
  network_mask = var.red.mascara

  permissions = "640"
  user        = opennebula_user.usuario.name
  group       = opennebula_group.grupo.name

  security_groups = [opennebula_security_group.grupo_seguridad.id]
}

resource "opennebula_virtual_network_address_range" "rango_direcciones" {
  virtual_network_id = opennebula_virtual_network.red.id
  ar_type            = "IP4"
  size               = var.red.numero_ips
  ip4                = "172.20.${var.red.subred}.${var.red.ip_inicial+(var.network)*var.red.numero_ips}"
}
