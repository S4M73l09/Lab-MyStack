# Lab-MyStack

Este repositorio has sido creado para servir como un entorno educativo para el conocimiento de herramientas `DevOps/CI/CD` y el uso de mas herramientas.

Cada apartado contendra un README.md explicativo que mostrara el uso real de dichos ejemplos y explicaciones de los comandos, variables, rutas... Generando una documentacion clara y directa.

Tambien se mostrara enlaces a la documentacion oficial de las herramientas tocadas en cada apartado, para asi tener la disponibilidad de poder ver documentacion real en base a la tecnologia que queramos.

En este README se mostrara enlaces a todos los recursos oficiales al final de este, tambien se mostrara en el indice a continuacion, este repositorio es totalmente educativo en buenas practicas y ejemplos de dichas tecnologias.

En el siguiente indice se mostrara los contenidos futuros para que puedas seleccionar lo que mas quieras conocer.

## Indice

- [Pipelines Basicos](#pipelines-basicos)
   - [Explicaciones de los pipelines](#explicaciones-de-los-pipelines)
   - [Explicaciones de ejemplos de pipelines](#explicacion-de-ejemplos-de-pipelines)
- [Docker](Docker-example)
   - [compose](Docker-example/compose)
     - [app-db](Docker-example/compose/app-db)
     - [dev](Docker-example/compose/dev)
     - [observability](Docker-example/compose/observability)
     - [proxy](Docker-example/compose/proxy)
     - [redis](Docker-example/compose/redis)
     - [secrets](Docker-example/compose/secrets)
     - [README](Docker-example/compose/README.md)
- [Documentaciones oficiales](#documentaciones-oficiales)

---

En este apartado se mostrara las explicaciones y ejemplos para el uso de workflows o pipelines de CI/CD, mostrando como funciona y evolucionando poco a poco para aprender de mejor manera el uso de estos, tambien añadiendo complejidad conforme mas queramos evolucionar.

# Pipelines Basicos

## Explicaciones de los pipelines

Los workflows de **Github Actions** son creados en la misma ruta de `.github/workflows/HERE.yaml` y estos pipelines usan una estructura simple de visualizar.

- Estructura general en los workflows
    - `trigger(on)` → `jobs` → `setup` → `install`→ `validate/test`

### Por que se sigue este orden

- `trigger`:Define cuando debe ejecutarse el workflow, por ejemplo en `push`, `pull_request` o manualmente `workflow_dispatch`
- `jobs`: Es el bloque encargado de ejecutar los pasos o `steps` del workflow.
   - Dentro de los jobs ya podemos ver diferentes steps:
     - `setup`: Prepara el entorno necesario, como una version concreta de `python`, `Node.js` o una autenticacion con un provider ***(Azure/GCP/AWS)*** mediante ***OIDC*** por ejemplo
     - `install`: Instala dependencias o herramientas necesarias para validar o desplegar
     - `validate/test`: Ejecuta pruebas, linting o comprobaciones de seguridad
     - `artifact/deploy`: Publica artefactos o realiza el despliegue si todo lo anterior ha salido bien
     - `verify`: Comprueba que el resultado final es correcto o que el despliegue ha terminado como se esperaba

### Cuándo se usa cada tipo de pipeline

- Pipeline basico:
  - Se usa para validar que un cambio no rompe el repositorio. Suele incluir `checkout`, alguna comprobacion simple y tests.

- Pipeline de Python:
  - Se usa cuando el proyecto necesita preparar un entorno concreto, instalar dependencias y ejecutar validaciones reales sobre el codigo.

- Pipeline de Terraform:
  - Se usa para validar y desplegar infraestructura como codigo. Normalmente incluye autenticacion con cloud, `fmt`, `validate`, `plan` y en algunos casos `apply`.

  > Pequeña nota aclaratoria de que cada inicio de un step, debe contener el checkout y el inicio con OIDC de cualquier provider.

- Pipeline de Ansible:
  - Se usa para automatizar configuraciones o aprovisionamiento. Puede generar inventario, ejecutar playbooks y guardar artefactos de salida.

   > Los workflows de Ansible son mas modulables en funcion a lo que se necesite, y no siguen tanto un entandar clasico, si no que siguen mas logica del propio stack que se quiere desplegar.

- Pipeline orientado a Docker:
  - Se usa para validar, construir, analizar y publicar imagenes. En escenarios reales suele incluir `build`, `scan`, `push` y verificacion final.

   > Recuerda que en casos de usar docker para providers como Azure/GCP, se requiere Auth - Registry y Deploy tanto de kubernetes como docker.

### Errores comunes en pipelines

- Variables de entorno mal escritas.
- Ramas mal definidas en `trigger`.
- Dependencias no instaladas en el runner.
- Comandos que funcionan en local pero no en el entorno de `Github Actions`.
- Falta de permisos para acceder a providers, registros o secretos.

## Explicacion de ejemplos de pipelines

En este apartado se mostraran ejemplos de `pipelines` basicos donde se muestran su uso:

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

---

Este siguiente `pipeline` usa codigo de `Python` alojado en la carpeta [App_python_basic](/App_python_basic).

Puedes ver de que se encarga dicho codigo en su [`README.md`](/App_python_basic).

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
      - [`Test_App_python/test_app.py`](/App_python_basic/Test_App_python/test_app.py) importado desde [`App_python_test/app.py`](/App_python_basic/App_python_test/app.py)

  Objetivo educativo:
  - Entender la estructura con Python
  - Ver como funciona
  - Validar que el pipeline corre perfectamente y el codigo de python igual
</details>

---

[`.github/workflows/Basic-image-docker.yaml`](./.github/workflows/Basic-image-docker.yaml)

<details>
  <summary><strong>Explicacion de Basic-image-docker.yaml</strong></summary>

  Este workflow se ejecuta en:
  - `push` a la rama main
  - `pull_request`

  Qué hace:
  1. Utiliza permiso de escritura y lectura
  2. Añade concurrency para que solo se pueda activar un run
  3. Hace checkout del repositorio
  4. Construye una imagen Docker utilizando el compose de `Docker-example/compose/app-db-compose.yaml`
  5. Muestra los contenedores ejecutandose
  6. Espera para verficar la salud de dichos contenedores
  7. Muestra log sobre la verificacion del punto anterior
  8. Despues de la verificacion, los contenedores se eliminan

  Objetivo educativo:
  - Entender el uso de CI/CD para `compose.yaml`
  - Ver como funciona
  - Validar que el pipeline se ejecuta de manera satisfactoria
</details>

# Documentaciones oficiales

  Aqui encontraras la documentacion de cada herramienta usada en este repositorio educativo.

- [🏗️ Terraform](https://developer.hashicorp.com/terraform)
- [⚙️ GitHub Actions](https://docs.github.com/es/actions)
- [🐳 Docker](https://docs.docker.com/manuals/)
- [🔧 Ansible](https://docs.ansible.com/)
- [☁️ Azure](https://learn.microsoft.com/es-es/azure/?product=popular)
- [☁️ Google Cloud](https://docs.cloud.google.com/docs?hl=es-419)
- [☸️ Kubernetes]
- [🛡️ Trivy]
- [✅ Checkov]
- [🐍 Python](https://docs.python.org/es/3/)


---

# Herramientas DevOps principales

`Azure` - `Gcloud` - `Terraform` - `Ansible` - `Actions` - `Docker` - `Kubernetes` - `Checkov` - `Trivy` - `OPA/conftest`

