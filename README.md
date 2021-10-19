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

Restore de base de datos:

```bash
    # Entrar al contenedor db_container
    docker exec -it db_container /bin/bash

    # Hacer restore
    psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -f componentes_django.sql
    psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -f componentes_positivos_residentes_dia.sql

    # Salir del contenedor
    'Ctrl + D'
```
---
Correr `manage.py`:

```bash
    # Entrar al contenedor app_container
    docker exec -it app_container /bin/bash

    # Correr el 'migrate'
    python3 manage.py migrate

    # Cargar datos, mapa, e iconos
    python3 manage.py loaddata iconos mapas
        
    # Crear usuario administrador
    python3 manage.py createsuperuser

    # Salir del contenedor
    'Ctrl + D'

    # Reiniciar servicio 'app'
    docker-compose restart app

    ir a http://localhost:8000/admin/
```
