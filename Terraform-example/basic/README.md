# Basic

Aqui se muestra los archivos basicos necesarios que se utilizan en una configuracion usando Terraform.

## Indice

- [Objetivo del ejemplo](#objetivo-del-ejemplo)
- [Estructura de archivos](#estructura-de-archivos)
- [Explicacion de cada archivo](#explicacion-de-cada-archivo)
- [Comandos basicos](#comandos-basicos)
- [Objetivo educativo](#objetivo-educativo)

## Objetivo del ejemplo

Esta muestra de ejemplo se usa de manera local como prueba medida de como funciona Terraform, para ello cada archivo cumple con una funciona especifica.

La idea no es desplegar infraestructura real todavia, sino entender:
- la estructura minima de un proyecto `Terraform`
- el uso de variables
- el uso de outputs
- el ciclo `init`, `fmt`, `validate`, `plan`, `apply` y `destroy`

## Estructura de archivos  

- `main.tf`
- `outputs.tf`
- `terraform.tfvars.example`
- `variables.tf`
- `.terraform.lock.hcl`

## Explicacion de cada archivo

#### [`main.tf`](main.tf)
<details>
 <summary><strong> Explicacion de dicho archivo </strong></summary>

 Este es el archivo principal donde se monta la configuracion de Terraform.

 En el, se define:
 1. La version minima de `Terraform`
 2. El provider necesario
 3. El recurso que se va a crear

 En este ejemplo, el recurso es un archivo local generado con el provider `local`.
</details>

---

#### [`variables.tf`](variables.tf)
<details>
 <summary><strong> Explicacion de dicho archivo </strong></summary>
 
 Este archivo define las `variables` de entrada que utilizara la configuracion

 En este caso:
 - `file_name`: nombre del archivo a crear
 - `file_content`: contenido que se escribira en el archivo

 Su objetivo es separar la configuracion del recurso de los valores concretos.
</details>

---

#### [`outputs.tf`](outputs.tf)
<details>
 <summary><strong> Explicacion de dicho archivo </strong></summary>

 Este archivo define las salidas de la configuracion cuando esta completa.

 Sirve para mostrar informacion util despues de aplicar Terraform, como:  
 - el nombre del archivo generado
 - el contenido del archivo
</details>

---

#### [`terraform.tfvars.example`](terraform.tfvars.example)
<details>
 <summary><strong> Explicacion de dicho archivo </strong></summary>

 Este archivo contiene valores de ejemplo para las variables del proyecto.

 Su objetivo es mostrar como se pasan datos concretos a Terraform sin escribirlos dentro de `main.tf`
</details>

---

#### [`.terraform.lock.hcl`](.terraform.lock.hcl)
<details>
 <summary><strong> Explicacion de dicho archivo </strong></summary>

 Este archivo especial se crea al momento de inicializar Terraform, guarda las versiones de los diferentes providers y guarda los hashes de estos. 

 Se tiene que re-generar si cambias version de Terraform en el `main.tf`.

 sirve para:
 - fijar version de Terraform
 - Guarda los hashes de providers
</details>


## Comandos basicos

Inicializar Terraform:
```bash
terraform init
```  
Actualizar la version de Terraform y de paso su `.terraform.lock.hcl`
```bash
terraform init -upgrade
```  
Formatear los archivos:
```bash
terraform fmt
```  
Validar la configuracion:
```bash
terraform validate
```  
Ver plan de ejecucion usando las variables de `terraform.tfvars.example`:
```bash
terraform plan -var-file="terraform.tfvars.example"
```  
Aplicar los cambios usando las variables de `terraform.tfvars.example`:
```bash
terraform apply -var-file="terraform.tfvars.example"
```  
Eliminar los recursos creados usando las variables de `terraform.tfvars.example`:
```bash
terraform destroy -var-file="terraform.tfvars.example"
```  

## Objetivo educativo

- Entender la estructura minima de un proyecto `Terraform`
- Aprender el flujo basico de trabajo
- ver como se usan variables y outputs
- Preparar la base para ejemplos futuros con `Azure`, `GCP` o `AWS`