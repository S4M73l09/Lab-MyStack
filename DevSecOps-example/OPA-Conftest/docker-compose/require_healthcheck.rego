package main

healthcheck_exceptions := {
  "adminer",
  "db",
}

deny[msg] {
  some service_name
  service := input.services[service_name]
  not healthcheck_exceptions[service_name]
  not service.healthcheck
  msg := sprintf("El servicio '%s' no define healthcheck.", [service_name])
}
