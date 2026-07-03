package main

local_images := {
  "basic-app-db:latest",
}

deny contains msg if {
  some service_name
  service := input.services[service_name]
  image := service.image
  not local_images[image]
  not contains(image, "@sha256:")
  msg := sprintf("El servicio '%s' no usa digest en la imagen.", [service_name])
}