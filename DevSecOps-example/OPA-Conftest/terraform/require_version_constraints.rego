package main

deny[msg] {
  not input.terraform.required_version
  msg := "La configuracion de Terraform no define required_version."
}

deny [msg] {
  not input.terraform.required_providers
  msg := "La configuracion de Terraform no define required_providers."
}