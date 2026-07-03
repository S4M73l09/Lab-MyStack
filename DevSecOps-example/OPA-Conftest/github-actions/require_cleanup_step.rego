package main

deny[msg] {
  some job_name
  job := input.jobs[job_name]
  not has_cleanup(job.steps)
  msg := sprintf("El job '%s' no incluye un paso de limpieza final.", [job_name])
}

has_cleanup(steps) {
  some i
  contains(lower(steps[i].name), "cleanup")
}
