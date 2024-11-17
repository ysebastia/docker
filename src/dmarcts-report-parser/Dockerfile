FROM docker.io/ysebastia/wget:1.24.5-r0 AS downloader

RUN wget -q https://github.com/techsneeze/dmarcts-report-parser/archive/refs/heads/master.zip \
  && unzip -q master.zip

FROM debian:12.8-slim
ARG DEBIAN_FRONTEND=noninteractive
ARG HTTPS_PROXY
ARG HTTP_PROXY
ENV http_proxy=$HTTP_PROXY
ENV https_proxy=$HTTPS_PROXY
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libclass-dbi-mysql-perl=1.00-5 \
    libfile-mimeinfo-perl=0.33-1 \
    libio-socket-inet6-perl=2.73-1 \
    libio-socket-ip-perl=0.41-2 \
    libmail-imapclient-perl=3.43-1 \
    libmail-mbox-messageparser-perl=1.5111-2 \
    libmime-tools-perl=5.510-1 \
    libperlio-gzip-perl=0.20-1+b1 \
    libxml-simple-perl=2.25-2 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=downloader /tmp/dmarcts-report-parser-master/ /app/
COPY config.inc.conf /app/dmarcts-report-parser.conf
WORKDIR /app
CMD [ "perl", "dmarcts-report-parser.pl", "-i"]