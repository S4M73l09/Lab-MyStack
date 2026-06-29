package main

deny contains msg if {
  some job_name
  job := input.jobs[job_name]
  not has_checkout(job.steps)
  msg := sprintf("El job '%s' no incluye actions/checkout.", [job_name])
}

has_checkout(steps) if {
  some i
  steps[i].uses == "actions/checkout@v4"
}
