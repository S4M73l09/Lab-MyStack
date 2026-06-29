# OPA / Conftest para GitHub Actions

En esta carpeta se muestran policies `.rego` orientadas a validar workflows de `GitHub Actions`. La idea es aplicar `policy as code` sobre los archivos YAML de CI/CD para reforzar buenas practicas basicas.

## Que valida cada archivo `.rego`

[`require_checkout.rego`](./require_checkout.rego)
<details>
  <summary><strong>Explicacion de la policy</strong></summary>

  Esta policy comprueba que cada job incluya el uso de `actions/checkout`.

  Que hace:
  1. Recorre los jobs del workflow
  2. Revisa la lista de `steps`
  3. Busca el uso de `actions/checkout@v4`
  4. Si no lo encuentra, genera un mensaje `deny`

  Objetivo educativo:
  - reforzar el uso correcto del checkout en workflows que necesitan acceder al repositorio
</details>

[`require_permissions.rego`](./require_permissions.rego)
<details>
  <summary><strong>Explicacion de la policy</strong></summary>

  Esta policy comprueba que el workflow defina el bloque `permissions` de forma explicita.

  Que hace:
  1. Revisa el nivel superior del workflow
  2. Comprueba si existe `permissions`
  3. Si no existe, devuelve un mensaje `deny`

  Objetivo educativo:
  - evitar workflows con permisos implicitos
  - reforzar el principio de minimo privilegio
</details>

[`require_cleanup_step.rego`](./require_cleanup_step.rego)
<details>
  <summary><strong>Explicacion de la policy</strong></summary>

  Esta policy revisa si los jobs contienen un paso de limpieza final.

  Que hace:
  1. Recorre los jobs del workflow
  2. Analiza el nombre de cada `step`
  3. Busca un paso cuyo nombre contenga `cleanup`
  4. Si no lo encuentra, genera un mensaje `deny`

  Objetivo educativo:
  - recordar la importancia de limpiar recursos temporales
  - reforzar buenas practicas en workflows que levantan contenedores o generan artefactos temporales
</details>

## Comando basico

Probar un workflow contra estas policies:

```bash
conftest test .github/workflows/Basic-image-docker.yaml --policy DevSecOps-example/OPA-Conftest/github-actions
```

## Objetivo general

Estas policies no sustituyen una revision completa de seguridad, pero sirven para mostrar como aplicar reglas automaticas sobre workflows de `CI/CD` usando `OPA` y `Conftest`.
