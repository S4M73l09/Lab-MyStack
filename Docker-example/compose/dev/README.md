# Dev

En esta carpeta se aloja lo indispensable para el correcto funcionamiento del ejemplo de uso de entornos productivos en `Docker` usando sus `compose.yaml`.

## Lista de ficheros y explicacion de este

[.env](./.env)
<details>
   <summary><strong>Explicacion de este fichero</strong></summary>

   Este archivo es un `.env` es decir, guarda las variable necesarias para el correcto funcionamiento del `compose.yaml` que queramos, normalmente no se suben a repos principalmente por temas de seguridad, al ser este repositorio un entorno educativo, se uede subir para comprender el funcionamiento de este.

   Este archivo `.env` apunta al compose de [`dev-compose.yaml`](../dev-compose.yaml), el cual este mismo consume para obtener los credenciales correctos y levantar el contenedor.
</details>