package main

deny[msg] {
  some service_name
  service := input.services[service_name]
  service.ports
  service_name != "nginx"
  service_name != "app"
  msg := sprintf("El servicio '%s' publica puertos al host y deberia revisarse si es necesario.", [service_name])
}
