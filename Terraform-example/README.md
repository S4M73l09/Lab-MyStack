# Terraform

## Indice

- [Explicacion de Terraform](#explicacion-de-terraform)
- [Estado deseado vs real](#estado-deseado-vs-real)
- [Estructura de directorio](#estructura-de-directorio)
    - [Terraform basico](basic)
    - [Modulos de Terraform](modules)
    - [Pipelines de Terraform](pipelines)
    - [providers](providers)
- [Documentacion de Terraform](#documentacion-de-terraform)

---

## Explicacion de Terraform

***Terraform***es una herramienta de infraestructura como codigo (IaC) desarrollada por ***HashiCorp*** que nos permite definir, aprovisionar y gestionar recursos de infraestructura (como bases de datos, servidores y redes) en multiples proveedores de entorno cloud (AWS, Azure y GCP) y locales mediante archivos de configuracion legibles.

Utiliza el ***Lenguaje de configuracion de HashiCorp (HCL)*** para describir el estado final deseado de la infraestructura; la herramienta genera automáticamente un plan de ejecución para alcanzar ese estado, identificando dependencias y garantizando un despliegue consistente, reproducible y versionado.


## Estado deseado vs Real

Terraform cuenta con una capacidad para detectar y reconciliar diferencias ("drift") mediante los siguientes pasos:

1. Lectura del estado deseado: Terraform lee tus archivos de configuracion (.tf) donde defines qué recursos deben existir y sus propiedades.

2. Consulta del Estado Actual (refresh): Antes de planificar, Terraform consulta las APIs del proveedor (AWS, Azure, GCP, etc.) para obtener el estado real de de los recursos que gestiona. Compara esta informacion con su archivo de estado local o remoto (terraform.tfstate).

3. Detección de Diferencias (Plan): Genera un plan de ejecución comparando el ***Estado deseado*** (código) contra el ***Estado real*** (nube).

  - Si la infraestructura real ha cambiado manualmente (ej. alguien modificó un grupo de seguridad en la consola), Terraform detecta esa ***desviación*** (drift).

  - Si el código ha cambiado, Terraform calcula las acciones necesarias para alcanzar el nuevo estado.

4. Ejecución (Apply): Aplica solo los cambios estrictamente necesarios (crear, actualizar o destruir) para alinear la realidad con el código.


## Estructura de directorio

Para mejorar el entorno educativo, esta parte del repositorio cuenta con una estructura simple de visualizar para abarcar de mejor manera los ejemplos educativos:

- [Terraform basico](basic): Cuenta con los archivos basicos de configuracion de Terraform a la vez que nos muestra una explicacion detallada de la funcion de cada uno.

- [Modulos de Terraform](modules): En este directorio se encuentra tanto la explicacion como el funcionamiento de lo modulos que se pueden asigar a Terraform para tareas concretas, como crear un modulo que apague una VM si esta no ha sido usada durante 30 minutos.

- [Pipelines de Terraform](pipelines): En esta ruta se muestra el uso de pipelines de `Terraform`, donde se muestran buenas practicas, el uso de Artifacts, validacion, practicas `DevSecOps` y todo ello explicando de forma concisa el uso de estos pipelines

> nota: En DevOps, los pipelines se formulan en cuestion al contexto del proyecto, estos pipelines que se muestran son solo formas de ejemplificar su uso, esto no describe la practica que se lleve en empresas.

- [providers](providers): Aqui se cuenta con la explicacion del uso de Terraform en grandes entornos Cloud como `Azure`, `AWS` y `GCP`.

---

# Documentacion de Terraform

#### Documentacion de Terraform

[🏗️ Terraform](https://developer.hashicorp.com/terraform)

#### Repositorio directo de Terraform

[🏷️ Repo Terraform](https://github.com/hashicorp/terraform)