# Docker

En esta seccion se muestra una explicacion mas detallada de unas de las herramientas mas importantes para la seccion de contenedores, incluido se muestra los ejemplos y comandos varios para verificar la salud de las imagenes y las formas de conectarlos por ejemplo a un flujo de trabajo usando un pipeline con `Actions`.

Todos los `compose.yaml` cuentan con comentarios explicando cada paso dentro de los archivos, y de todos los ejemplos mostrados.

## Indice

- [Explicaciones de ejemplos practicos Compose](#explicaciones-de-ejemplos-practicos-compose)  
- [Comandos Utiles para el uso continuo de Docker](#comandos-utiles-para-el-uso-continuo-de-docker)

## Explicacion de estructuras

Docker se estructura usando archivos .yaml, y mediante uso de ***services*** los cuales despues se conforman por las imagenes que queremos añadir a nuestro `-compose.yaml`.

Aqui podemos ver un ejemplo basico de un archivo `compose.yaml` usando un servicio basico como `Nginx` usando version tag + digest.

## Explicaciones de ejemplos practicos Compose

[`basic-compose.yaml`](basic-compose.yaml)
<details>
  <summary><strong> Explicacion de compose </strong></summary>

  Este `compose.yaml` se encarga de levantar un contenedor con una imagen `Nginx` tageada usando digest.
  ***Digest*** se le denomina al hash de una version en particular de una App o services, la cual lo vuelve totalmente inmutable a cambios futuros, basicamente añade reproducibilidad debido a que esta jamas cambiara por estar orientada al mismo hash.

  Para verificar el digest y el tag de cualquier servicio que queramos, debemos tener en cuenta que debe existir antes en el registro remoto (Ya sea `Docker hub`, `ECR`, `GCR` o algun registro privado), en este caso se usara comandos proporcionados por docker:

  - `docker buildx imagetools inspect 'imagen que queremos ver'`

  Esto nos muestra un amplio abanico de versiones tanto para equipos con arquitecturas distintas como `ARM`-`amd64`-`riscv64`...

  Por ejemplo en este `compose.yaml` pongamos de ejemplo el uso de un digest + tag para la imagen de `Nginx`

  - `docker buildx imagetools inspect nginx:1.30.2-alpine`

  y elegimos la version de la aquitectura correcta.

  ***Cuidado*** Se usa la version `alpine` por que son las mas ligeras en entornos Linux, tambien debido a que tienen solo los paquetes indispensables, por lo cual el riesgo de invulnerabilidades es ligeramente mejor.

  Qué hace:
  1. Levanta el contenedor de `Nginx`
  2. Muestra su funcionamiento
  3. Usa imagen inmutable gracias a `tag + manifest`
  4. Una vez visto el funcionamiento, se baja el contenedor

  Comandos mostrados para verificar el funcionamiento:

- `docker compose -f basic-compose.yaml up -d` -> Levanta el servicio/contenedor
- `docker compose -f basic-compose.yaml ps` -> Muestra funcionamiento del servicio
- `docker logs 'nombre-servicio'` -> Muestra los logs del servicio dentro del contenedor
- `curl http://localhost:8080` -> Prueba la conectividad del servicio de Nginx
- `docker compose -f basic-compose.yaml down` -> Elimina/Remueve el contenedor y los servicios alojados a este

  Objetivo educativo:
  - Visualizar como crear un docker basico
  - Mirar como funciona los servicios dentro de Docker
  - Uso de Digest + tag para seguridad y escalabilidad
  - Probar su funcionamiento
  - Eliminar o remover el contenedor/servicios
</details>

---

En este siguiente ejemplo podemos ver el uso de una imagen `Docker` utilizando `Postgres y Adminer` lo cual nos permite ver el flujo por ejemplo de crear, desplegar, visualizar y administrar una base de datos de ***PostgresSQL*** añadiendo digest + tag, ademas de añadir comandos para detener y eliminar contenedores para refrescar el volumen del `.compose.yaml`

[db-compose.yaml](db-compose.yaml)
<details>
  <summary><strong> Explicacion de este db-compose </strong></summary>

  Este `db-compose.yaml` levanta una base de datos con unas ***variables*** para acceder a esta mediante el uso de `adminer`, la base de datos desplegada utiliza `PostgresSQL` y version ***digest + tag***

  Ademas si queremos añadir cambios al contenedor mediante su docker-compose.yaml puedes recrearlo usando esta serie de comandos:
  
  - Primero el estado de los contenedores:
    - `docker compose -f db-compose.yaml ps`

  - Vemos los logs de todos los servicios:
    - `docker compose -f db-compose.yaml logs`

  - ver los logs de un servicio concreto (postgres)
    - `docker logs basic-progres`

  - ver los logs de Adminer:
    - `docker logs basic-adminer`

  - Si queremos actualizar/recrear los contenedores si hemos cambiado algo en su compose:
    - `docker compose -f db-compose.yaml up -d`

Dicho comando anterior es exactamente igual al despliegue en segundo plano de los contenedores, esto se debe a que docker lee el `-compose.yaml` y recrea los recursos nuevos o cambiados, eso si los volumenes se deben eliminar y crearlos de nuevo si se ha tocado algo que haya influido a estos, para ello se usa este comando:

  - Para detener y eliminar contenedores y sus volumenes, usamos el comando normal pero añadiendo un `-v`:  
    - `docker compose -f db-compose.yaml down -v`

  Qué hace:
  1. Despliega una base de datos utilizando `postgres` y permite su administracion gracias a `Adminer`
  2. Verifica que la conexion se ha formulado correctamente
  3. Se crea la base de datos sin problemas
  4. `Adminer` permite conectarnos a la base de datos
  5. Verificamos que si podemos acceder gracias a las variables dentro del `db-compose.yaml`

  Objetivo educativo:
  - Observar el despliegue de una base de datos
  - Comprobar el funcionamiento de volumenes con postgres
  - Confirmar la conexion correctamente
  - Verificar usuario y contraseña
</details>

[app-db-compose.yaml](app-db-compose.yaml)  
<details>
  <summary><strong> Explicacion de este compose </strong></summary>

  Este `compose.yaml` levanta una imagen de base de datos creada por Python, la cual despues `Postgres`levanta con ***variables*** configuradas, y su servicio propio y `Adminer` como gestor de la base de datos.

  Debido a la configuracion de esta, dicho apartado de que hace cada archivo puedes verlo siguiendo dandole [`click`](./app-db).

  Se encuentra la explicacion de que hace cada archivo y su finalidad en el propio compose.

  Por supuesto, siguiendo la filosofia de mayor seguridad, se ha usado versiones `Digest + tag`.

  Qué hace:
  1. Despliega contenedor de base de datos, reconstruido por una app de `python`, `Postgres` y `Adminer`
  2. Verifica la conexion de los contenedores
  3. `Adminer` se conecta a la base de datos sin problemas
  4. Se verifica si podemos acceder gracias a los datos y variables usadas dentro del `app-db-compose.yaml`

  Objetivo educativo:
  - Obervar el despliegue de la base de datos
  - Observar la comunicacion de la `app.py` - `Dockerfile` y `requirements.txt`
  - Comprender la red interna de los contenedores para su comunicacion
  - Ver una composicion multiservicio mas cercana a un caso real
</details>

[redis-compose.yaml](redis-compose.yaml)
<details>
  <summary><strong> Explicacion de este compose </strong></summary>

  Este `compose.yaml` usa el servicio redis, y ¿que es redis?

  `Redis` es un almacen de datos en memoria muy rapido. Se usa sobre todo como cache, sistema de colas, almacenamiento temporal o para guardar datos de acceso muy frecuente.

  A diferencia de una base de datos tradicional como `Postgres`, `Redis` esta pensado para operaciones muy rapidas de lectura y escritura sobre estructuras simples como claves y valores.

  Qué hace:
  1. Levanta un servicio de cache con `docker-compose`
  2. Protege el acceso con contraseña
  3. valida la salud del contenedor
  4. Permite leer y escribir datos

  Objetivo educativo: 
  - Observar un servicio de cache con `docker-compose`
  - como proteger el acceso con contraseña
  - como validar la salud del contenedor
  - como leer y escribir datos manualmente con `redis-cli`

  Ademas redis usa archivos de configuracion, esto nos permite separar la configuracion del `compose.yaml`del `redis.conf`.

  Puedes ver la explicacion de dicho archivo y sus opciones aqui: [redis.conf](redis)

  Comandos para comprobar que Redis responde correctamente:

  - Comprobar el uso mediante un ping
    ```bash
    docker exec -it basic-redis redis-cli -a practice_redis_pass ping
    ```
  - Guardar un valor
    ```bash
    docker exec -it basic-redis redis-cli -a practice_redis_pass set demo "hola"
    ```
  - Leer un valor
    ```bash
    docker exec -it basic-redis redis-cli -a practice_redis_pass get demo
    ```
  Que hace cada comando:
  - `ping`: comprueba que el servidor Redis esta operativo y responde con `PONG`  
  - `set`: guarda una clave con un valor  
  - `get`: recupera el valor almacenado en una clave

  Ademas en este `compose.yaml` usa el contenedor `redis-client` el cual actua como contenedor auxiliar para comprobar que la conexion hacia `Redis` funciona correctamente dentro de la red interna de `Docker`.

  No almacena datos ni expone puertos. Su funcion principal es educativa y de validacion.

  Que permite practicar:
  - comprobar conectividad entre contenedores
  - usar `redis-cli` desde otro servicio distinto a `redis`
  - validar que la autenticacion con contraseña funciona
  - entender como un contenedor puede comunicarse con otro usando el nombre del servicio, en este caso `redis`

  En este ejemplo, `redis-client` depende de que `redis` este sano y despues ejecuta un `ping` autenticado contra el servicio.

  Esto demuestra que:
  - `redis` esta operativo
  - la red interna entre contenedores funciona
  - la contraseña configurada es valida
</details>

[proxy-compose.yaml](proxy-compose.yaml)
<details>
  <summary><strong> Explicacion de este compose </strong></summary>

  Este `compose.yaml` usa la carpeta ***[app-db](app-db)*** para levantar una base de datos ***Postgres*** para dicha app, usando `Nginx` como punto de entrada externo, este reenvia las peticiones hacia la app. La app a su vez permite su conexion a ***Postgres*** dentro de la red interna de `Docker`.

  Este `compose.yaml` ***es un ejemplo de arquitectura web básica con proxy + aplicacion + base de datos.***

  Qué hace:
  1. Levanta una app Flask
  2. Levanta una base datos Postgres para esa app
  3. Levanta `Nginx` como punto de entrada externo
  4. Hace que `Nginx` reenvié las peticiones hacia la app
  5. La app, a su vez, se conecta a `Postgres` dentro de la red interna de Docker

  Objetivo educativo:
  - Observar el trafico resultante en la red interna
  - Observar el uso de Nginx en un entorno mas serio
  - Conocer el como se conecta la app, Nginx y la base de datos de Postgres

  En este ejemplo tambien se usa un archivo de configuracion externo a este `compose.yaml` el cual puedes ver su funcionamiento [aqui](proxy/)
</details>

[worker-compose.yaml](worker-compose.yaml)
<details>
  <summary><strong> Explicacion de este compose </strong></summary>

  Este imagen construye un entorno `python` reutilizable para dos servicios distintos del compose:

  1. Aplicacion web principal
  2. El worker que procesa tareas en segundo plano

  Esta imagen incluye:
  - `Python 3.12` como imagen base
  - instalacion de dependencias desde `requirements.txt`
  - el archivo `app.py`
  - el archivo `worker.py`

  El ***comportamiento*** por defecto, es que la imagen arranca la aplicacion web con `python app.py`, a la vez el servicio `worker` el compose sobrescribe el comando y ejecuta `python worker.py`

  Que hace:
  1. La imagen arranca la aplicacion web con `python app.py`
  2. Arranca el servicio `worker`
  3. Dicho servicio compose sobrescribe el comando y ejecuta `python worker.py`
  4. Se comprueba su funcionamiento final

  Objetivo educativo:
  - entender como una misma imagen puede reutilizarse para varios servicios
  - diferenciar entre el `CMD` por defecto del `Dockerfile` y el `command` definido en `docker compose`
  - ver un caso mas realista donde no cada contenedor necesita una imagen completamente distinta

  Aqui se puede ver el archivo `python` usando en el `compose.yaml` [worker.py](app-db/worker.py) 
</details>

[dev-compose.yaml](dev-compose.yaml)
<details>
  <summary><strong> Explicacion de este compose </strong></summary>

  Esta imagen construye usando [`app-db](app-db) en modo desarrollo, haciendo que cualquier cambio arrojado dentro de dicha carpeta, se visualice en el contenedor. A su vez `Postgres` se levanta de forma aislada para el entorno de desarrollo. 

  Este ejemplo muestra el uso de:
  - `env_file` para no meter variables inline en el compose
  - `volumes` con bind mount para montar código local dentro del contenedor

  Que hace:
  1. La imagen arranca mirando a [`app-db`](app-db)
  2. Todo cambio arrojado a la carpeta, se visualizara en el `compose.yaml`
  3. Ambos servicios se alojan separados, para visualizar mejor el entorno de desarollo.

  Objetivo educativo:
  - entender como se desarrolla un entorno serio `dev`
  - el uso de archivos `.env`
  - comprender el uso de `volumes` con bind mount
  - separacion y aislamiento para entornos reproductivos

  Puedes ver el archivo [`.env`](app-db/.env) 
</details>

[multi-network-compose.yaml](multi-network-compose.yaml)
<details>
  <summary><strong> Explicacion de este compose </strong></summary>

  Esta imagen se construye reutilizando ***proxy + app + db***, para crear un entorno de aislamiento.

  Para ello creamos las redes necesarias, en este caso `frontend` y `backend`. Con ello podemos alojar cada servicio a cada red que queramos, para asi poder aislar cada servicio de manera correcta.

  La idea es:  
  - `nginx` en red ***frontend***
  - `app` en ***frontend*** y ***backend***
  - `db` solo en ***backend***

  Así:  
  - el exterior solo llega a `nginx`
  - `nginx` puede hablar con `app`
  - `app` puede hablar con `db`
  - `db` no queda expuesta ni al host ni a la red frontend

  Objetivo educativo:
  - comprender las redes separadas, en este caso `frontend` y `backend`
  - comprender y visualizar el aislamiento de red para `nginx`, `db` y `app`
  - entender que servicio puede hablar con quien
</details>

[secrets-config-compose.yaml](secrets-config-compose.yaml)
<details>
  <summary><strong> Explicacion de este compose </strong></summary>

  En esta imagen se utiliza ***secrets*** como ejemplo para mostrar que se puede añadir seguridad en el `compose.yaml` para asi no mostrar contraseñas directamente dentro de dicho compose.

  Puedes ver en dicha [aqui](secrets) el uso de dichos archivos `env_file`.

  > Matiz importante: 
  > - esto no es seguridad fuerte real como un secreto gestionado por una plataforma, ejemplo Github con sus secrets o vars.
  > - pero sí es un paso educativo muy bueno para no meter todo inline en YAML

  Objetivo educativo:
  - `env_file` nos enseña mantener una configuracion no sensible
  - muestra seguridad real en el `compose.yaml`
  - se muestra diferencia entre "configuracion" y "secreto"
  - nos prepara mentalmente para herramientas futuras como Vault, SOPS, Kubernetes Secrets o AWS/GCP/Azure y sus secrets managers.
</details>

---

## Comandos Utiles para el uso continuo de Docker

### Control de versiones  
Inspeccion de version digest + tag:
```bash
docker buildx imagetools inspect <NAME_SERVICE>
```

### Arranque
Arranque de contenedor del archivo ***-compose.yaml*** en segundo plano:
```bash
docker compose -f <FILE_PATH-COMPOSE> up -d
```

### Estado del contenedor y logs de todos los servicios
Ver el estado de los contenedores:
```bash
docker compose -f <FILE_PATH-COMPOSE> ps
```  
Ver los logs de todos los servicios:
```bash
docker compose -f <FILE_PATH-COMPOSE> logs
```  
Ver los logs de un servicio concreto:
```bash
docker logs <SERVICE_NAME>
```

### Ejecutar comandos dentro de contenedores
Para ejecutar comandos dentro de contenedores ya arrancados:
```bash
docker exec <CONTAINER_NAME> <COMMAND>
```  
Para ejecutar comandos dentro de contenedores ya arracandos con terminal interactiva:
```bash
docker exec -it <CONTAINER_NAME> <COMMAND>
```
> Normalmente este comando se usa de manera normal para interactuar comodamente con el proceso del contenedor. 

### Actualizar/recrear contenedores tras cambios en el compose
Actualizar despues de cambios, docker recrea segun los cambios, recuerda que si cambia volumenes, es necesario borrar y crearlos de cero:
```bash
docker compose -f <FILE_PATH-COMPOSE> up -d
```  
Forzar recreación:
```bash
docker compose -f <FILE_PATH-COMPOSE> up -d --force-recreate
```
Descargar versiones más recientes de las imágenes:
```bash
docker compose -f <FILE_PATH-COMPOSE> pull
```
Detener y eliminar contenedores:
```bash
docker compose -f <FILE_PATH-COMPOSE> down
```  
Detener y eliminar contenedores junto con el volumen:
```bash
docker compose -f <FILE_PATH-COMPOSE> down -v
```
