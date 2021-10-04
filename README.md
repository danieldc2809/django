# test-docker-bamapas

Repositorio de testing que tiene como objetivo dockerizar la aplicación de bamapas (rama `integracion_matrice`).

https://repositorio-asi.buenosaires.gob.ar/ssppbe_usig/bamapas/-/tree/integracion_matrice


Ejecutar el siguiente comando para integrar el codigo original de `bamapas` al proyecto:
    
        git submodule update -i


Crear archivo `.env`:

        cp .env-example .env


Restore de base de datos:

        # Entrar al contenedor de la db
        docker exec -it db_container /bin/bash
        psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -f componentes.sql
        # Salir del contenedor con ´Ctrl + D´