resource "opennebula_acl" "crear_recursos" {
  user     = "@${opennebula_group.grupo.id}"
  resource = "VM+IMAGE+TEMPLATE+DOCUMENT+VROUTER+SECGROUP+NET/@${opennebula_group.grupo.id}"
  rights   = "USE+CREATE+MANAGE+ADMIN"
}

resource "opennebula_acl" "crear_redes" {
  user     = "#${opennebula_user.usuario.id}"
  resource = "CLUSTER/*"
  rights   = "ADMIN"
}
