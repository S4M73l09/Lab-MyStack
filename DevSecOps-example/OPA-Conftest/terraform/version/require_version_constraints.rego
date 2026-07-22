package main

deny[msg] {
  not input.terraform[0].required_version
  msg := "La configuracion de Terraform no define required_version."
}

deny [msg] {
  not input.terraform[0].required_providers
  msg := "La configuracion de Terraform no define required_providers."
}