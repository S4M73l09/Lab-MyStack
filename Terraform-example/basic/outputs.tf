output "generated_file_name" {
  description = "Nombre del archivo generado por Terraform."
  value       = local_file.example_file.filename
}

output "generated_file_content" {
  description = "Contenido del archivo generado."
  value       = local_file.example_file.content
}