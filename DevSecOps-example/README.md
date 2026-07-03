# DevSecOps

En este apartado se mostrara el uso de herramientas para añadir seguridad, escaneos y validacion a los pipelines que se usan para desplegar servicios de manera corriente.

Ya sea pipelines CI/CD que levanten un servicio de `Docker-compose`, `Terraform`, `Azure/GCP` o realmente cualquier workflow que levante un servicio, necesita unas medidas y pautas de seguridad para reducir al minimo fallos de vulnerabilidades tanto de manera social como de manera tecnica.

Existen herramientas que añaden politicas claras para un correcto funcionamiento y buenas practicas como el uso de separar credenciales por entornos, o el uso de `OIDC` en entornos Cloud, `Validacion TFLint` para Terraform, `Checkov` para IaC...

En este bloque se mostrara buenas pautas y herramientas que de manera normal se usan para añadir seguridad real.

Todos los ejemplos son didacticos y no describen realmente el funcionamiento real de las empresas, pero es un buen paso mostrar que herramientas nos ayudan en el dia a dia para un correcto desempeño.

---

## Indice

- [Que se entiende por practicas DevSecOps](#que-se-entiende-por-practicas-devsecops)
- [Explicacion de cada herramienta](#explicacion-de-cada-herramienta)
  - [Trivy](#trivy)
  - [Checkov](#checkov)
  - [OPA / Conftest](#opa--conftest)
    - [OPA-Conftest](OPA-Conftest)
      - [github-actions](OPA-Conftest/github-actions)
  - [TFLint](#tflint)
  - [OIDC](#oidc)
- [Runtime y su uso](#runtime-y-su-uso)
- [Ejemplos y usos](#ejemplos-y-usos-de-dichas-herramientas-en-pipelines)
- [Documentacion oficial](#documentacion-oficial)


---

# Que se entiende por practicas DevSecOps

Las practicas `DevSecOps` buscan integrar seguridad dentro del ciclo de vida del desarrollo y del despliegue, en lugar de tratarla como una fase separada al final.

Esto implica:

- validar configuraciones antes del despliegue
- detectar vulnerabilidades en imagenes, dependencias o infraestructura
- aplicar politicas de seguridad como codigo
- reducir el uso de credenciales estaticas y mejora de credenciales temporales
- reforzar el principio de minimo privilegio en pipelines y entornos cloud

Para ello, existen multitud de herramientas tanto para la `validacion`, uso de politicas claras, separacion de credenciales por entornos y uso de buenas practicas para asegurar un correcto desempeño sin necesidad de vulnerar datos sensibles.

El siguiente bloque mostrara el uso de algunas de estas herramientas.

---

# Explicacion de cada herramienta

## Trivy

`Trivy` es una herramienta de analisis de seguridad que permite escanear imagenes, filesystem, configuraciones e infraestructura como codigo.

### Que puede escanear

- imagenes Docker
- filesystem de un proyecto
- configuraciones y manifiestos
- dependencias y vulnerabilidades conocidas

### Por que empezar por Trivy

Es una de las herramientas mas comunes por entornos `DevSecOps` porque permite introducir controles de seguridad de forma simple y progresiva.

### Comandos basicos de Trivy

Escanear el filesystem del proyecto:
```bash
trivy fs .
```

Escanear una imagen de Docker:
```bash
trivy image nginx:1.30.2-alpine
```

Mostrar solo vulnerabilidades altas y criticas:
```bash
trivy image --severity HIGH,CRITICAL nginx:1.30.2-alpine
```

Fallar si encuentra vulnerabilidades:
```bash
trivy image --exit-code 1 nginx:1.30.2-alpine
```

Escanear una carpeta concreta:
```bash
trivy fs ./Docker-example
```

Estos comandos toman ejemplos del repo, la idea es que se entienda.

- `fs` para archivos del proyecto
- `image` para imagenes de contenedores
- `--severity` para filtrar niveles de vulnerabilidades
- `--exit-code 1` para usarlo en CI/CD

Con estos comandos, basta para poder arrancar bien.

## Checkov

`Checkov` es una herramienta de analisis de seguridad para infraestructuras como codigo (`IaC`)

Se usa para detectar configuraciones inseguras o malas practicas en archivos como:
- `Terraform`
- `Kubernetes`
- `Dockerfile`
- `docker-compose`
- `GitHub Actions`

### Por que se usa

Permite aplicar controles de seguridad antes del despliegue, detectando errores de configuracion en el propio codigo declarativo.

### Comandos basicos de Checkov

Escanear el directorio actual:
```bash
checkov -d .
```

Escanear una carpeta concreta:
```bash
checkov -d ./Docker-example
```

Escanear un archivo concreto:
```bash
checkov -f Docker-example/compose/app-db-compose.yaml
```

Mostrar solo checks fallidos:
```bash
checkov -d . --quiet
```

Saltar un check concreto:
```bash
checkov -d . --skip-check CKV_DOCKER_2
```

## OPA / Conftest

`OPA` (`Open Policy Agent`) permite definir reglas usando `Rego`.
`Conftest` usa esas reglas para validar archivos de configuracion como `docker-compose`, `Kubernetes` o `Terraform`.

### Objetivo educativo

En este apartado se muestran politicas sencillas aplicadas a los archivos `compose` del repositorio.

Las policies de ejemplo validan:
- que no se use la etiqueta `latest`
- que los servicios tengan `healthcheck`
- que no todos los servicios publiquen puertos sin control

### Comando basico 

Probar un compose contra las policies:
```bash
conftest test Docker-example/compose/app-db-compose.yaml --policy DevSecOps-example/OPA-Conftest
```
Puedes encontrar las `policies.rego` en la carpeta de [OPA-Conftest](OPA-Conftest).

## TFLint

`TFLint` es una herramienta de validacion orientada a `Terraform`. Se usa para detectar errores, malas practicas y configuraciones mejorables en archivos de infraestructura como codigo.

### Por que se usa  

Su objetivo no es sustituir a `terraform validate`, sino complementarlo con validacion de reglas mas especificas y comprobaciones adicionales.

### Comandos basicos

Inicializar plugins y reglas:
```bash
tflint --init
```  
Analizar el directorio actual:
```bash
tflint
```  
Analizar una carpeta concreta:
```bash
tflint --chdir=./terraform
```  
Analizar recursivamente varios modulos:
```bash
tflint --recursive
```

## OIDC

`OIDC` (`openID Connect`) es un mecanismo de autenticacion federada muy usado en pipelines modernos de `CI/CD`.

Permite que herramientas como `GitHub Actions` se autentiquen contra proveedores cloud como `Azure`, `Google Cloud` o `AWS` sin necesidad de guardar credenciales estaticas en el repositorio.

Su valor principal dentro de `DevSecOps` es mejorar la seguridad del pipeline reduciendo el uso de secretos persistentes y aplicando un modelo de identidad temporal.

---

# Runtime y su uso

## Filosofia runtime-first

Una buena practica dentro de `DevSecOps` es que la mayor parte de configuraciones, credenciales o identidades se resuelvan en tiempo de ejecucion del pipeline, en lugar de quedar definidas de forma estatica dentro del repositorio o dentro de un job sensible en el propio pipeline.

Esto implica:  
- evitar credenciales hardcodeadas
- usar secretos gestionados por la plataforma
- usar `OIDC` o identidades temporales cuando sea posible
- cargar configuraciones sensibles solo durante la ejecucion
- reducir la persistencia innecesaria de datos sensibles

El objetivo es minimizar la superficie de exposicion y reforzar la seguridad del flujo de `CI/CD`.

---

# Ejemplos y uso de dichas Herramientas en Pipelines

Aqui se muestra el uso de dichas herramientas en los pipelines de CI/CD, permitiendonos practicar y visualizar como funciona cada una.

## Pipelines DevSecOps

***Pipeline basico de Docker con DevSecOps***

### [`.github/workflows/basic-devsecops-docker.yaml`](../.github/workflows/basic-devsecops-docker.yaml)

<details>
  <summary><strong> Explicacion del pipeline</strong></summary>

  Este pipeline se ejecuta en:
  - `push` a la rama `main`
  - `pull_request`
  - `workflow_dispatch`

  Que hace:
  1. Hace `checkout` del repositorio
  2. Valida el archivo `compose` con `docker compose config`
  3. Ejecuta `Checkov` contra `app-db-compose.yaml`
  4. Construye la imagen Docker de la aplicacion
  5. Ejecuta `Trivy` para escanear la imagen construida
  6. Guarda el resultado de `Trivy` en un artifact descargable
  7. Levanta los servicios del compose
  8. Verifica la salud de la aplicacion mediante `/health`
  9. Muestra logs si algo falla
  10. Elimina contenedores y volumenes al finalizar

  Objetivo educativo:
  - ver como integrar validacion de configuracion e imagen en un pipeline real
  - entender el orden entre validacion, build, escaneo y comprobacion de salud
  - mostrar un flujo `DevSecOps` sencillo pero cercano a un caso real
</details>


***pipeline avanzado de Docker con DevSecOps***

### [`.github/workflows/advanced-devsecops-docker.yaml`](../.github/workflows/advanced-devsecops-docker.yaml)

<details>
  <summary><strong> Explicacion del pipeline</strong></summary>

  Este pipeline se ejecuta en:
  - `push` a la rama `main`
  - `pull_request`
  - `workflow_dispatch`

  Que hace:
  1. Hace `checkout` del repositorio
  2. Valida la configuracion del compose con `docker compose config`
  3. Ejecuta validacion de misconfigurations de `Checkov`
  4. Instala y configura `Conftest`
  5. Se aplica las politicas `.rego` despues de la instalacion anterior
  6. Construye la imagen de `Docker`
  7. Empieza el escaneo de vulnerabilidades de dicha imagen con `Trivy`
  8. Se sube el artifact del reporte generado por `Trivy`
  9. Verifica que la App responde a su endpoint de salud
  10. Muestra los contenedores ejecutandose
  11. Muestra logs si falla algo
  12. Borra los contenedores y los volumenes

  Objetivo educativo:
  - Entender el como integrar validacion de configuracion e imagen en un pipeline real
  - Entender el orden entre validacion, build, escaneo y comprobacion real
  - Mostrar el flujo `DevSecOps` sencillo pero cercano a un caso real
  </details>

# Documentacion oficial

- [🛡️ Trivy](https://trivy.dev/docs/latest/getting-started/installation/)  
- [✅ Checkov](https://www.checkov.io/1.Welcome/Quick%20Start.html)  
- [📏 OPA/Conftest](https://www.conftest.dev/)  
    - [Archivos .rego](https://www.openpolicyagent.org/docs)  
- [🏗️ TFLint](https://github.com/terraform-linters/tflint)  
- [🪪 OIDC](https://openid.net/developers/how-connect-works/)  
     - AWS  
       - [Federacion IAM](https://docs.aws.amazon.com/es_es/IAM/latest/UserGuide/id_roles_providers_oidc.html)  
       - [OIDC](https://docs.github.com/es/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-aws)  
     - Azure  
       - [OIDC para github](https://docs.github.com/es/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-azure)  
       - [OpenID 2.0](https://learn.microsoft.com/es-es/entra/identity-platform/v2-protocols-oidc)  
     - Gcloud
       - [OIDC para github](https://docs.github.com/es/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-google-cloud-platform)  
       - [OIDC para gitlab](https://docs.gitlab.com/ci/cloud_services/google_cloud/)  

