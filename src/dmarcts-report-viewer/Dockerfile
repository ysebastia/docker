FROM php:8.1.2-apache-bullseye
ARG DEBIAN_FRONTEND=noninteractive
RUN docker-php-ext-install mysqli
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    unzip=6.0-26 \
    wget=1.21-1+deb11u1 \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /tmp
RUN wget --no-check-certificate -q https://github.com/techsneeze/dmarcts-report-viewer/archive/refs/heads/master.zip \
	&& unzip -q master.zip
WORKDIR /tmp/dmarcts-report-viewer-master
RUN mv * /var/www/html/  \
	&& cp /var/www/html/dmarcts-report-viewer.php /var/www/html/index.php \
	&& rm -r /tmp/master.zip /tmp/dmarcts-report-viewer-master
WORKDIR /var/www/html
COPY config.inc.php /var/www/html/dmarcts-report-viewer-config.php
