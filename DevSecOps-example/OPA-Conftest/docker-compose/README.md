# OPA / Conftest

En esta carpeta se muestran ejemplos basicos de `policy as code` usando `OPA` y `Conftest`. Las policies estan escritas en `Rego` y se usan para validar archivos `docker compose` del repositorio.

Las policy `.rego` estan pensadas justamentes para el uso educativo de los `compose`, por lo cual estas policies no son universales sino que estan adaptadas a los ejemplos de los `compose`.

## Que valida cada archivo `.rego`

### [`deny_latest_tag.rego`](./deny_latest_tag.rego)
<details>
  <summary><strong>Explicacion de la policy</strong></summary>

  Esta policy revisa los servicios definidos en un archivo `compose` y comprueba si alguna imagen usa la etiqueta `latest`.

  Tambien se encarga de añadir una politica para el uso de versiones Digest.

  Que hace:
  1. Recorre los servicios del compose
  2. Permite que la imagen local basic-app-db:latest si pueda usar `latest`
  3. Lee el valor de `image`
  4. Detecta si termina en `:latest`
  5. Devuelve un mensaje `deny` si encuentra ese caso

  Objetivo educativo:
  - evitar versiones ambiguas
  - reforzar el uso de tags fijos o `tag + digest`
</details>



### [`require_digest.rego`](./require_digest.rego)
<details>
  <summary><strong>Explicacion de la policy</strong></summary>

  Esta policy revisa los servicios definidos en un archivo `compose` y comprueba si las imagenes usan `@sha256` o comunmente llamado versiones `Digest`.

  Que hace:
  1. Recorre los servicios del compose
  2. Excluye la imagen local de basic-app-db:latest de la politica
  3. detecta si alguna imagen no contiene `@sha256`
  4. devuelve un mensaje `deny` si encuentre ese caso

  Objetivo educativo:
  - Aprender cuando excluir una imagen de una politica amplia
  - Visualizar el uso de `Digest`
</details>



### [`require_healthcheck.rego`](./require_healthcheck.rego)
<details>
  <summary><strong>Explicacion de la policy</strong></summary>

  Esta policy comprueba que cada servicio del compose tenga definido un bloque `healthcheck`.

  Que hace:
  1. Recorre todos los servicios
  2. Comprueba si existe `healthcheck`
  3. Si no existe, genera un mensaje `deny`

  Objetivo educativo:
  - reforzar la validacion de salud de contenedores
  - evitar servicios que arrancan sin comprobaciones basicas
</details>



### [`restrict_public_ports.rego`](./restrict_public_ports.rego)
<details>
  <summary><strong>Explicacion de la policy</strong></summary>

  Esta policy detecta servicios que publican puertos al host y obliga a revisar si realmente deben estar expuestos.

  Para ello se ha usado de manera intencional una lista de servicios que dicha politica ignorara para mostrar el modelo educativo y tambien muestra un ejemplo mas completo a la hora de no crear politicas tan restrictivas frente a los servicios expuestos.

  Que hace:
  1. Recorre los servicios del compose
  2. Comprueba si existe el bloque `ports`
  3. Permite algunos servicios concretos definidos como excepcion
  4. Genera un mensaje `deny` para el resto

  Objetivo educativo:
  - entender el principio de minimo acceso
  - revisar que no todos los servicios se publiquen innecesariamente
</details>

---

## Comando basico

Probar un archivo `compose` contra estas policies:

```bash
conftest test Docker-example/compose/app-db-compose.yaml --policy DevSecOps-example/OPA-Conftest/docker-compose
```

## Objetivo general

Estas policies no buscan cubrir todos los casos reales, si no mostrar de forma sencilla como aplicar `policy as code` sobre configuraciones de contenedores.

En la carpeta de [github-actions](../github-actions) puedes encontrar los archivos `.rego` orientados a escenarios de `Workflows` de CI/CD.
