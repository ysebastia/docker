FROM docker.io/ysebastia/wget:1.21.4-r0 as downloader

WORKDIR /tmp
RUN wget -q https://github.com/techsneeze/dmarcts-report-viewer/archive/refs/heads/master.zip \
  && unzip -q master.zip

FROM php:8.1.18-apache-bullseye
ARG DEBIAN_FRONTEND=noninteractive
RUN docker-php-ext-install mysqli

COPY --from=downloader /tmp/dmarcts-report-viewer-master/ /var/www/html/
WORKDIR /var/www/html
RUN cp dmarcts-report-viewer.php index.php
COPY config.inc.php /var/www/html/dmarcts-report-viewer-config.php
