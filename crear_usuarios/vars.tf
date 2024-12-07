variable "username" {
  default = "ciber-xx"
}

variable "password" {
  default = "12345Abcde"
}

variable "network" {
  default = 1
}

variable "hostname" {
  default = "opennebula.example.org"
}

variable "cuota" {
  default = {
    cpu            = 4
    memoria        = 12
    disco_sistema  = 100
    disco_imagenes = 50
  }
}

variable "red" {
  default = {
    puerta_enlace = "172.20.1.2"
    mascara       = "255.255.0.0"
    subred        = "228"
    dns           = "192.168.10.1 1.1.1.1"
    ip_inicial    = 10
    numero_ips    = 10
  }
}
