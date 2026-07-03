package main

deny[msg] {
  some service_name
  service := input.services[service_name]
  not service.healthcheck
  msg := sprintf("El servicio '%s' no define healthcheck.", [service_name])
}
