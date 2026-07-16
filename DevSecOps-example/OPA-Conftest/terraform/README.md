# OPA / Conftest para terraform

En esta carpeta se muestran policies `.rego` orientadas a validar configuraciones de `Terraform.`

## Que valida cada archivo `.rego`

### [`require_version_constraints.rego`](./require_version_constraints.rego)

Esta policy comprueba que la configuracion defina:
- `required_version`
- `required_providers`

Objetivo:
- reforzar la fijacion de versiones
- evitar configuraciones ambiguas

### [`require_variable_description.rego`](./require_variable_description.rego)

Esta policy comprueba que las variables definidas en Terraform incluyan `description`.

Objetivo:
- mejorar la legibilidad
- reforzar buenas practicas de documentacion

## Comando basico

Probar una configuracion Terraform contra estas policies:
```bash
conftest test Terraform-example/basic/main.tf Terraform-example/basic/variables.tf --policy DevSecOps-example/OPA-Conftest/terraform
```

Para pipelines de `CI/CD` puedes agregar que Conftest use las policy por bloque en vez de por archivos, aunque por archivos resulta ser mas controlado, para el uso de pipelines, es mucho mejor hacerlo por bloque.

Conftest aplicara las politicas a todos los archivos dentro de la carpeta donde se indique.
```bash
conftest test Terraform-example/basic --policy DevSecOps-example/OPA-Conftest/terraform
```
