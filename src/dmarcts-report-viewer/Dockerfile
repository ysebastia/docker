FROM docker.io/ysebastia/wget:1.25.0-r2 AS downloader

RUN wget -q https://github.com/techsneeze/dmarcts-report-viewer/archive/refs/heads/master.zip \
  && unzip -q master.zip

FROM php:8.1.31-apache-bookworm
ARG DEBIAN_FRONTEND=noninteractive
RUN docker-php-ext-install mysqli

COPY --from=downloader /tmp/dmarcts-report-viewer-master/ /var/www/html/
WORKDIR /var/www/html
RUN cp dmarcts-report-viewer.php index.php
COPY config.inc.php /var/www/html/dmarcts-report-viewer-config.php
