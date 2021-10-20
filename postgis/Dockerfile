FROM mdillon/postgis

EXPOSE 5432

RUN mkdir /opt/db_dump \
    && chmod +x /opt/db_dump

COPY ./db_dump /opt/db_dump

COPY ./restore_db.sh /docker-entrypoint-initdb.d

WORKDIR /opt/db_dump