package main

allowed_public_services := {
  "app",
  "nginx",
  "adminer",
  "db",
  "redis",
  "prometheus",
  "grafana",
}

deny[msg] {
  some service_name
  service := input.services[service_name]
  service.ports
  not allowed_public_services[service_name]
  msg := sprintf("El servicio '%s' publica puertos al host y deberia revisarse si es necesario.", [service_name])
}
