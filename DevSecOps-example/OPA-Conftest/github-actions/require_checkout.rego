package main

deny[msg] {
  some job_name
  job := input.jobs[job_name]
  not has_checkout(job.steps)
  msg := sprintf("El job '%s' no incluye actions/checkout.", [job_name])
}

has_checkout(steps) {
  some i
  steps[i].uses == "actions/checkout@v4"
}
