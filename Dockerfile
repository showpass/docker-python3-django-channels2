FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" > /etc/apk/repositories 
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories 
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories  
RUN apk update
RUN apk add --update curl curl-dev # Curl
RUN apk --no-cache add openssl openssl-dev git
RUN apk --no-cache add gdal
RUN apk --no-cache add gdal-dev
RUN apk --no-cache add py-gdal geos-dev geoip-dev
RUN apk --no-cache add postgresql-dev
RUN apk --no-cache add linux-headers  # psutil
RUN apk --no-cache add bash  # bash
RUN apk --no-cache add libevent-dev  # Gevent
RUN apk --no-cache add libjpeg-turbo-dev zlib-dev libffi-dev build-base jpeg-dev freetype-dev # Pillow
#RUN apk --no-cache add git  # Git
RUN apk --no-cache add nano htop postgresql-client  # Debugging
RUN apk --no-cache add libxslt-dev libxml2-dev # lxml

ENV LIBRARY_PATH /lib:/usr/lib:$LIBRARY_PATH  # Pillow

ADD requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt # Install dependencies that take a long time
RUN pip install Pandas==0.25.0
RUN rm requirements.txt
