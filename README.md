# componentes-v1-dockerizado

Repositorio dockerizado de la aplicación de componentes V1 (rama `componentes`).

https://repositorio-asi.buenosaires.gob.ar/ssppbe_usig/bamapas/-/tree/componentes


Ejecutar el siguiente comando para integrar el codigo original de `bamapas` al proyecto:
    
        git submodule update -i


Crear archivo `.env`:

        cp .env-example-dev .env


Levantar servicios:

        docker-compose up -d --build


Para levantar servicios localmente con `pgadmin` ejecutar:

        cp .env-example-local .env-local
        docker-compose -f docker-compose-local.yaml up -d --build


En caso de ser necesario ejecutar con `sudo`.

---
    ir a http://localhost/admin/
```
