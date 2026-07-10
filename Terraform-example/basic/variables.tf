variable "file_name" {
  description = "El nombre del archivo que Terraform creara en local."
  type        = string
}

variable "file_content" {
  description = "Contenido que tendra el archivo generado."
  type        = string
}