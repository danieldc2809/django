FROM postgres:13.4

EXPOSE 5432

RUN mkdir /opt/db_dump

COPY ./db_dump /opt/db_dump

# CMD [ "psql -U ${POSTGRES_USER} -h 0.0.0.0 -d ${POSTGRES_DB} -f /opt/db_dump/componentes.sql" ]