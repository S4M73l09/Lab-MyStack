# PROXY Nginx

De manera correcta, normalmente se separa el archivo de configuracion de `Nginx` del `compose.yaml` asi evitamos exponerlo directamente al compose.

## Explicacion de nginx.conf

El archivo alojado aqui se encarga de la configuracion directa del servicio de `Nginx`.

Este [nginx.conf](nginx.conf) se encarga de:  
- Còmo escucha `Nginx`
- A qué servicio reenvía trafico
- Què cabeceras pasa
- Cómo actúa como proxy
