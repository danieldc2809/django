#!/bin/sh

psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /opt/db_dump/componentes_django.sql || {
    echo "Failed to restore componentes_django."
    exit 1
}

psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -f /opt/db_dump/componentes_positivos_residentes_dia.sql || {
    echo "Failed to restore componentes_positivos_residentes_dia."
    exit 1
}
