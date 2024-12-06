output "usuarios" {
  value = [
    for i, usuario in opennebula_user.usuarios[*] :
    {
      usuario = usuario.name
      red     = opennebula_virtual_network_address_range.rangos_direcciones[i].ip4
    }
  ]
}
