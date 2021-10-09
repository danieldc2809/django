# test-docker-bamapas

Repositorio de testing que tiene como objetivo dockerizar la aplicación de bamapas (rama `componentes`).

https://repositorio-asi.buenosaires.gob.ar/ssppbe_usig/bamapas/-/tree/componentes


Ejecutar el siguiente comando para integrar el codigo original de `bamapas` al proyecto:
    
        git submodule update -i


Crear archivo `.env`:

        cp .env-example .env


Levantar servicios:

        docker-compose up -d --build


Restore de base de datos:

```bash
        # Entrar al contenedor db_container
        docker exec -it db_container /bin/bash

        # Hacer restore
        psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -f componentes.sql

        # Salir del contenedor
        'Ctrl + D'
```

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

Levantar `bamapas`:

```bash
        # Entrar al contenedor app_container
        docker exec -it app_container /bin/bash

        # Instalar 'npm'
        npm install -s

        # Iniciar aplicacion
        npm  start

        ir a http://localhost:3000
```