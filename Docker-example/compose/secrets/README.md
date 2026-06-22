# Secrets

En esta ruta de repositorio, se mostrara los credenciales usados para el archivo `compose.yaml`.

## Que se usa aqui

- `.env`: para variables de configuracion no sensibles, como host, puerto, nombre de base de datos o usuario.
- `db_password.txt` y `app_password.txt`: para contraseñas montadas como archvos dentro del contenedor.

## Objetivo educativo

La idea es no dejar todos los datos dentro del `compose.yaml`, diferenciando entre:  
- configuracion comun
- secretos o credenciales

# Limitacion importante

Este ejemplo es util para practicar, pero no sustituye un gestor real de secretos como:
- Kubernetes Secretos
- HashiCorp Vault
- AWS Secrets Manager
- Google Secret Manager
- Azure Key Vault

