# Redis

En esta carpeta se alojan los archivos de configuraciones necesarios para el correcto funcionamiento del servicio de redis en los `compose.yaml`.

## Por que usa un archivo redis.conf

`redis.conf` se usa para separar la configuracion del servicio del archivo `compose`.

Esto permite:  
- definir opciones del servidor sin meter toda la configuracion dentro de `command`
- reutilizar una configuracion clara y mantenible
- practicar un escenario mas realista, ya que muchos servicios se configuran con archivos propios

En este caso, dicho [`redis.conf`](redis.conf) configura:  
- `appeandonly yes`: activa persistencia para guardar operaciones en disco  
- `save 60 1`: crea snapshots si hay al menos un cambio en 60 segundos  
- `maxmemory 256mb`: limita la memoria maxima usada por redis
- `maxmemory-policy allkeys-lru`: elimina claves menos usadas cuando se alcanza el limite de memoria  

