package main

deny[msg] {
  not input.permissions
  msg := "El workflow no define permissions explicitamente."
}
