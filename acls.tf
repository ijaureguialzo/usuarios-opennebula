resource "opennebula_acl" "crear_recursos" {
  count = local.usuarios.numero

  user     = "@${opennebula_group.grupos[count.index].id}"
  resource = "VM+IMAGE+TEMPLATE+DOCUMENT+VROUTER+SECGROUP+NET/@${opennebula_group.grupos[count.index].id}"
  rights   = "USE+CREATE+MANAGE+ADMIN"
}

resource "opennebula_acl" "crear_redes" {
  count = local.usuarios.numero

  user     = "#${opennebula_user.usuarios[count.index].id}"
  resource = "CLUSTER/*"
  rights   = "ADMIN"
}
