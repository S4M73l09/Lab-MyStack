package main

deny contains msg if {
  not input.permissions
  msg := "El workflow no define permissions explicitamente."
}