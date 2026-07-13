# Basic Local File Module

Este modulo muestra una estructura minima de modulo en `Terraform` usando el provider `local`.

## Estructura de archivos

- `main.tf`
- `variables.tf`
- `outputs.tf`

## Explicacion de cada archivo

[`main.tf`](./main.tf)
<details>
  <summary><strong>Explicacion de main.tf</strong></summary>

  Este archivo contiene el recurso principal del modulo.

  En este caso:
  - crea un archivo local
  - usa variables para definir nombre y contenido

  Su objetivo es mostrar como un modulo encapsula un recurso reutilizable.
</details>

[`variables.tf`](./variables.tf)
<details>
  <summary><strong>Explicacion de variables.tf</strong></summary>

  Este archivo define las variables de entrada del modulo.

  En este ejemplo:
  - `file_name`
  - `file_content`

  Su objetivo es permitir que el modulo sea reutilizable sin modificar directamente el recurso.
</details>

[`outputs.tf`](./outputs.tf)
<details>
  <summary><strong>Explicacion de outputs.tf</strong></summary>

  Este archivo define las salidas del modulo.

  Sirve para devolver informacion util al bloque que consume el modulo, como por ejemplo el nombre del archivo generado.
</details>

## Objetivo educativo

- entender la estructura minima de un modulo
- ver como se separan recursos, variables y outputs
- preparar la base para modulos mas complejos en entornos cloud
