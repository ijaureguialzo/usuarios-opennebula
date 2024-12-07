output "usuario" {
  value = {
    usuario = opennebula_user.usuario.name
    red     = opennebula_virtual_network_address_range.rango_direcciones.ip4
  }
}
