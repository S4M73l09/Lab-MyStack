module "example_file" {
  source       = "../basic-local-file"
  file_name    = "module-example.txt"
  file_content = "Generated from Terraform module"
}