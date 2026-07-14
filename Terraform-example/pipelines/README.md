# Pipelines de Terraform

En esta carpeta se mostraran ejemplos de `pipelines` orientados a trabajar con `Terraform` dentro de flujos de `CI/CD`, usando principalmente `GitHub Actions`.

## Objetivo del bloque

La idea de estos ejemplos no es solo ejecutar comandos de `Terraform`, sino mostrar como se automatiza la validacion, revision y posible despliegue de infraestructura como codigo dentro de un pipeline.

## Que se entiende por pipeline de Terraform

Un pipeline de `Terraform` es un workflow automatizado que permite ejecutar pasos de validacion o despliegue sobre archivos `.tf`.

De forma habitual, estos pipelines suelen incluir:

- `terraform fmt -check`
- `terraform init`
- `terraform validate`
- `terraform plan`
- herramientas de seguridad o calidad como `TFLint` y `Checkov`
- en escenarios mas avanzados, `terraform apply`

## Objetivo educativo

En este repositorio, los pipelines de Terraform se mostraran de forma progresiva:

1. Pipelines basicos de validacion
2. Pipelines con herramientas de calidad y seguridad
3. Pipelines con `plan`
4. Pipelines mas avanzados con autenticacion segura y despliegue real

## Relacion con otros bloques del repositorio

Este apartado se conecta con:

- `basic/`, para entender primero la estructura de Terraform
- `modules/`, para mostrar como se automatizan proyectos mas reutilizables
- `DevSecOps-example/`, donde se explican herramientas como `Checkov`, `TFLint` y `OIDC`

---

# Ejemplos de uso de pipelines de Terraform

#### [basic-terraform-validate.yaml](../.github/workflows/basic-terraform-validate.yaml)
<details>
 <summary><strong> Explicacion de este pipeline basico </strong></summary>

 Este `basic-terraform-validate.yaml` es un pipeline basico encargado de mostrar el orden a la hora de usar `Terraform` junto con `GitHub Actions`.

 Que hace:
 - Se activa con un `push`
 - hace `setup-terraform`
 - inicializa `Terraform`
 - Valida y crea un `plan`

 Objetivo educativo:
 1. Mostrar la estructura de un pipeline de `Terraform`
 2. observar el funcionamiento de este
 3. comprender los jobs de `Terraform`

</details>

