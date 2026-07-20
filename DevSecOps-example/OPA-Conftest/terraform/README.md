# OPA / Conftest para terraform

En esta carpeta se muestran policies `.rego` orientadas a validar configuraciones de `Terraform.`

## Que valida cada archivo `.rego`

### [`require_version_constraints.rego`](./version/require_version_constraints.rego)

Esta policy comprueba que la configuracion defina:
- `required_version`
- `required_providers`

Objetivo:
- reforzar la fijacion de versiones
- evitar configuraciones ambiguas

### [`require_variable_description.rego`](./variables/require_variable_description.rego)

Esta policy comprueba que las variables definidas en Terraform incluyan `description`.

Objetivo:
- mejorar la legibilidad
- reforzar buenas practicas de documentacion

Es mucho mejor crear policies para cada archivo de Terraform, asi podemos ejercer diferentes politicas en el mismo bloque de `Terraform`.

## Comando basico

Para pipelines de `CI/CD` puedes agregar que Conftest use las policy por bloque en vez de por archivos, aunque por archivos resulta ser mas controlado, para el uso de pipelines, es mucho mejor hacerlo por bloque.

Conftest aplicara las politicas a todos los archivos dentro de la carpeta donde se indique.
```bash
conftest test Terraform-example/basic --policy DevSecOps-example/OPA-Conftest/terraform
```  
Si queremos en todo caso aplicar las politicas a archivos separados. Por ejemplo, requerir version, en main.tf.
```bash
conftest test Terraform-example/basic/main.tf --policy DevSecOps-example/OPA-Conftest/terraform/version
```  
Si queremos aplicar politicas de por ejemplo, requerir descripciones en las variables en variables.tf.
```bash
conftest test Terraform-example/basic/variables.tf --policy DevSecOps-example/OPA-Conftest/terraform/variables
```

