package main

deny contains msg if {
  some service_name
  service := input.services[service_name]
  image := service.image
  endswith(image, ":latest")
  msg := sprintf("El servicio '%s' usa la etiqueta latest, lo cual no es razonable.", [service_name])
}