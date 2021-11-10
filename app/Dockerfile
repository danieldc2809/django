FROM python:3.8-slim-buster

EXPOSE 8000 3333

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

WORKDIR /opt

COPY ./bamapas/requirements.txt ./entrypoint.sh /opt/

RUN apt-get -q -y update \
    && apt-get -q -y install \
        curl \
        nano \
        git \
        libz-dev \
        libjpeg-dev \
        libfreetype6-dev \
        python-dev \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install -r requirements.txt \
    && mkdir /opt/app
   
COPY ./bamapas /opt/app

WORKDIR /opt/app

ENTRYPOINT ["sh", "/opt/entrypoint.sh"]