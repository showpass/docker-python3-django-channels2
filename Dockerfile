FROM python:3.7-alpine3.9

ENV PYTHONUNBUFFERED 1

RUN apk -q update
RUN apk -q add --update curl curl-dev # Curl
RUN apk -q --no-cache add openssl openssl-dev git
RUN apk -q --no-cache add py-gdal geos-dev geoip-dev gdal-dev gdal # PostGIS
RUN apk -q --no-cache add postgresql-dev
RUN apk -q --no-cache add linux-headers  # psutil
RUN apk -q --no-cache add bash  # bash
RUN apk -q --no-cache add libevent-dev  # Gevent
RUN apk -q --no-cache add py-pip gcc musl-dev libjpeg-turbo-dev python-dev zlib-dev libffi-dev build-base jpeg-dev freetype-dev # Pillow
#RUN apk -q --no-cache add git  # Git
RUN apk -q --no-cache add nano htop postgresql-client  # Debugging
RUN apk -q --no-cache add libxslt-dev libxml2-dev # lxml

ENV LIBRARY_PATH /lib:/usr/lib:$LIBRARY_PATH  # Pillow

ADD requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt # Install dependencies that take a long time
RUN rm requirements.txt
