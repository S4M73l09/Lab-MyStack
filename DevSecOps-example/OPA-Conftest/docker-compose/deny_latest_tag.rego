package main

local_images := {
  "basic-app-db:latest",
}

deny[msg] {
  some service_name
  service := input.services[service_name]
  image := service.image
  endswith(image, ":latest")
  not local_images[image]
  msg := sprintf("El servicio '%s' usa la etiqueta latest en una imagen que deberia fijarse mejor.", [service_name])
}
