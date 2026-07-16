package main

deny[msg] {
  some var_name
  variable := input.variable[var_name]
  not variable.decription
  msg := sprintf("La variable '%s' no define description.", [var_name])
}