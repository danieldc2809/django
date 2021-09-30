FROM ubuntu:18.04

EXPOSE 8000

WORKDIR /opt

COPY ./bamapas/requirements.txt /opt/requirements.txt

RUN apt-get update -y && apt-get install nano \
    && apt-get install -y python3 \
    && apt-get install -y python3-pip && python3 -m pip install --upgrade pip \
    && apt-get install -y libsasl2-dev \
    && apt-get install -y python-dev \
    && apt-get install -y libldap2-dev \
    && apt-get install -y libssl-dev \
    && python3 -m pip install -r requirements.txt \
    && apt-get install -y gdal-bin \
    && mkdir /opt/app
    
COPY ./bamapas /opt/app

WORKDIR /opt/app

# not working
# CMD ["python3 manage.py migrate"]