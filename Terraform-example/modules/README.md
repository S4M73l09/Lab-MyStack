# Modulos de Terraform

Un modulo de `Terraform` es un contenedor reutilizable que agrupa varios recursos relacionados para tratarlos como una ***unidad lógica única***. En cristiano, es simplemente un directorio con archivos de configuracion `.tf` (principalmente `main.tf`, `variables.tf` y `outputs.tf`) que pueden ser invocados desde otras configuraciones.

Normalmente `Terraform` encapsula el modulo raiz en cada configuracio, pero la gracia de esta reside en crear o consumir módulos secundarios para encapsular patrones de infraestructura complejos.

Por supuesto los modulos solucionan problemas complejos.

Si quieres ir a los ejemplos concretos y pasar la explicacion teorica, dale [Aqui](#ejemplos-concretos)

## ¿Que problema soluciona?

1. ***Eliminacion de duplicacion de codgo***: En lugar de copiar y pegar para crear diferentes recursos o instancias, se puede crear un modulo con la logica de dicho despliegue y este se podra reutilizar las veces que quieras, ahorrando superficie de error y codigo.

2. ***Estandarizacion y cumplimiento de politicas***: Permiten encapsular las mejores prácticas de la organización. Se puede crear un módulo de base de datos de datos que fuerce el cifrado de almacenamiento y y deshabilite el acceso público por defecto. 

3. ***Simplificacion o Abstraccion***: El uso de módulos puede ocultar la complejidad técnica detras de una interfaz simple. Por ejemplo el despliegue de un Kubernetes completo (Que requiere docenas de de recursos interconectados) invocando un solo módulo y pasando solo 3 o 4 parámetros clave, sin necesidad de entender cada recurso subyacente.

4. ***Mantenibilidad centralizada***: Si se necesita actualizar una configuracion (por ejemplo añadir una etiqueta nueva o cambiar una instancia), solo modificas el módulo en tu lugar. El cambio se propaga a todas las invocaciones de ese módulo al volver a aplicar la configuración, en lugar de tener que editar múltiples archivos dispersos.

Y como hablamos, son muy adaptables.

## ¿Por que son adaptables?

La adaptabilidad de estos modulos proviene justamente de su diseño basado en parámetros y composición:

- ***Interfaz parametrizada flexible***: Los módulos no son plantillas estáticas; definen variables de entrada (`variables.tf`) que permiten personalizar el comportamiento en cada invocación.

- ***Composición y anidamiento***: Los módulos pueden llamarse entre si. Basicamente un módulo puede llamar a otro, como piezas de lego que se van formando.

- ***Independencia del contexto***: Un módulo bien diseñado es agnóstico al entorno especifico. Gracias a la salida de `outputs.tf` esto expone solo lo necesario para que otros módulos puedan consumir esa informacion.

- ***Versionado y evolución***: Puedes utilizar diferentes versiones de un mismo módulo simultáneamente. Esto permite que un equipo adopte una nueva versión con caracteristicas avanzadas mientras otro se mantiene en una version estable, asi es posible adoptar nuevas caracteristicas de forma gradual.

## Ejemplos concretos

Aqui se mostrara ejemplos concretos, pese a que los módulos son adaptables y modulables en funcion al contexto del proyecto, aqui se mostraran algunos ejemplos para conocer su estructura y el como se reutiliza.

- [***basic-local-file***](basic-local-file): Modulo simple con la estructura basica  
- [***usage-example***](usage-example): Infraestructura basica donde se consumira dicho modulo  

---

