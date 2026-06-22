# App + DB

En esta seccion se muestra un ejemplo mas realista de `docker compose` usando una aplicacion propia, una base de datos `Postgres` y `Adminer` como gestor web. La idea es practicar no solo el despliegue de contenedores, si no tambien la conexion entre servicios, el uso de variables y la creacion de una imagen propia mediante `Dockerfile`.

## Indice

- [Objetivo del ejemplo](#objetivo-del-ejemplo)
- [Estructura de archivos](#estructura-de-archivos)
- [Explicacion de cada archivo](#explicacion-de-cada-archivo)
- [Flujo entre servicios](#flujo-entre-servicios)
- [Comandos utiles](#comandos-utiles)
- [Errores comunes](#errores-comunes)

## Objetivo del ejemplo

Este ejemplo tiene como objetivo mostrar un flujo de trabajo basico pero util:

1. Construir una imagen propia para una app sencilla en `Flask`
2. Levantar una base de datos `Postgres`
3. Conectar la app a la base de datos usando variables de entorno
4. Validar el estado de la app y de la base de datos con `healthchecks`
5. Administrar la base de datos desde navegador con `Adminer`

## Estructura de archivos

- `app.py`
- `requirements.txt`
- `Dockerfile`
- [`../app-db-compose.yaml`](../app-db-compose.yaml)

## Explicacion de cada archivo

[`app.py`](./app.py)
<details>
  <summary><strong>Explicacion de la aplicacion</strong></summary>

  Este archivo contiene una aplicacion minima en `Flask`.

  Que hace:
  1. Expone la ruta `/` para confirmar que la app ha arrancado
  2. Expone la ruta `/health` para probar la conexion real con `Postgres`
  3. Usa variables de entorno para obtener host, puerto, base de datos, usuario y contraseña
  4. Devuelve una respuesta `healthy` si consigue conectarse a la base de datos

  Objetivo educativo:
  - Ver una conexion real entre aplicacion y base de datos
  - Entender por que la app necesita las variables `POSTGRES_*`
  - Usar un endpoint de salud util para Docker
</details>

[`requirements.txt`](./requirements.txt)
<details>
  <summary><strong>Explicacion de dependencias</strong></summary>

  Este archivo define las librerias que necesita la aplicacion para funcionar.

  Dependencias principales:
  - `Flask` para levantar la app web
  - `psycopg2-binary` para conectar Python con `Postgres`

  Tambien aparecen otras librerias comunes del ecosistema `Flask` que pueden servir para evolucionar este ejemplo mas adelante.

  Objetivo educativo:
  - Entender como una imagen instala dependencias desde un fichero declarativo
  - Ver el papel de cada libreria principal dentro de la app
</details>

[`Dockerfile`](./Dockerfile)
<details>
  <summary><strong>Explicacion del Dockerfile</strong></summary>

  Este archivo construye la imagen propia de la aplicacion.

  Que hace:
  1. Usa `python:3.12-alpine` como imagen base
  2. Define `/app` como directorio de trabajo
  3. Copia `requirements.txt` e instala dependencias
  4. Copia `app.py` dentro de la imagen
  5. Expone el puerto `5000`
  6. Arranca la aplicacion con `python app.py`

  Objetivo educativo:
  - Practicar una imagen propia en lugar de usar solo imagenes publicas
  - Entender la diferencia entre `build` e `image`
</details>

[`worker.py`](./worker.py)
<details>
  <summary><strong>Explicacion del worker.py</strong></summary>

  Este archivo define un proceso en segundo plano que actua como trabajador dentro del compose [`worker-compose.yaml`](../worker-compose.yaml).

  Que hace:
  1. Se conecta al servicio `redis`
  2. Revisa la lista `jobs`
  3. Si encuentra una tarea, la procesa y la muestra por salida
  4. Si no encuentra nada, espera unos segundos y vuelve a comprobar

  Objetivo educativo:
  - entender el papel de un worker en una arquitectura distribuida
  - ver como un contenedor puede ejecutar tareas en segundo plano
  - practicar el uso de `Redis` como cola simple de trabajo
</details>



