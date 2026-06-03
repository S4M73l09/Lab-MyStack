# Lab-MyStack

Este repositorio has sido creado para servir como un entorno educativo para el conocimiento de herramientas `DevOps/CI/CD` y 
el uso de mas herramientas.

## Indice

- [Pipelines basicos](#Pipelines-Basicos (CI/CD))
- [Docker](Docker-example)



### Herramientas que se mostraran su uso

`Azure` - `Gcloud` - `Terraform` - `Ansible` - `Actions` - `Docker` - `Kubernetes` - `Checkov` - `Trivy` - `OPA/conftest`

---

En este apartado se mostrara las explicaciones y ejemplos para el uso de workflows o pipelines de CI/CD, mostrando como funciona y evolucionando poco a poco para aprender de mejor manera el uso de estos, tambien añadiendo complejidad conforme mas queramos evolucionar.

# Pipelines Basicos (CI/CD)

## Explicaciones de los pipelines

Los workflows de **Github Actions** son creados en la misma ruta de `.github/workflows/HERE.yaml` y estos pipelines usan una estructura simple de visualizar.

- Estructura general en los workflows
    - `trigger(on)` → `jobs` → `steps` → `validaciones` → `artefactos` → `despliegue`

- Estructura para despliegues en Terraform + Provider (Azure - GCP)
    - `name`→ `triggers(on)` → `jobs` → `Security_steps` →  `validate (TFLint)` →  `Terraform steps (Init/plan)` →  `approve_gate` →  `Terraform Apply` →  `Summary or Artifact`

    > Pequeña nota aclaratoria de que cada inicio de un step, debe contener el checkout y el inicio con OIDC de cualquier provider.

- Estructura para configuraciones usando Ansible + Provider (Azure - GCP)
   - `name`→ `triggers(on)` → `jobs` →  `Generate_inventory(Runtime)` →  `Run_ansible` → `Publish Artifact`

   > Los workflows de Ansible son mas modulables en funcion a lo que se necesite, y no siguen tanto un entandar clasico, si no que siguen mas logica del propio stack que se quiere desplegar.

- Estructura para despliegues con Docker + provider (Azure - GCP)
   - `name` → `triggers(on)` → `jobs` → `validate` → `test` → `build_image` → `scan_image` → `push_image` → `deploy` → `verify`

   > Recuerda que en casos de usar docker para providers como Azure/GCP, se requiere Auth - Registry y Deploy tanto de kubernetes como docker.

## Explicacion de ejemplos de pipelines

[`.github/workflows/Basic-ci.yaml`](./.github/workflows/Basic-ci.yaml)

<details>
  <summary><strong>Explicacion de Basic CI</strong></summary>

  Este workflow se ejecuta en:
  - `push` a la rama main
  - `pull_request`

  Qué hace:
  1. Hace checkout del repositorio
  2. Muestra la rama/ref actual (`github.ref`)
  3. Lista los archivos del proyecto
  4. Ejecuta una prueba simulada

  Objetivo educativo:
  - Entender la estructura mínima de Github Actions
  - Ver variables de contexto
  - Validar que el pipeline corre correctamente
</details>

[`.github/workflows/Basic-ci-python.yaml`](./.github/workflows/Basic-ci-python.yaml)

<details>
  <summary><strong>Explicacion de Basic-ci-python</strong></summary>

  Este workflow se ejecuta en:
  - `push` a la rama main
  - `pull_request`

  Qué hace:
  1. Utiliza permiso de escritura y lectura
  2. Añade concurrency para que solo se pueda activar un run
  3. Hace checkout del repositorio
  4. Hace set up y instala depedencias de `python` ***3.12***
  5. Hace validacion y check de la instalacion de python
  6. Ejecuta el codigo de python alojado en:
      - [`Test_App_python/test_app.py`](/Test_App_python/test_app.py) importado desde [`App_python_test/app.py`](/App_python_test/app.py)

  Objetivo educativo:
  - Entender la estructura con Python
  - Ver como funciona
  - Validar que el pipeline corre perfectamente y el codigo de python igual
  </details>