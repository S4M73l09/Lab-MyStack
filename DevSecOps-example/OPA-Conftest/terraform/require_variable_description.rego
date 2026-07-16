package main

deny[msg] {
  some var_name
  variable := input.variable[var_name]
  not variable.description
  msg := sprintf("La variable '%s' no define description.", [var_name])
}