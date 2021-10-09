FROM ubuntu:18.04

EXPOSE 8000 3000

WORKDIR /opt

COPY ./bamapas/requirements.txt /opt/requirements.txt

RUN apt-get -q -y update \
    && apt-get -q -y install \
        curl \
        nano \
        git \
        libssl-dev \
        libldap2-dev \
        libsasl2-dev \
        nodejs \
        python-dev \
        python3 \
        python3-pip \
        gdal-bin \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install -r requirements.txt \
    && mkdir /opt/app \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash
    
COPY ./bamapas /opt/app

WORKDIR /opt/app