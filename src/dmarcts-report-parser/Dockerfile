FROM debian:11.1-slim
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
	libclass-dbi-mysql-perl=1.00-4.1 \
	libfile-mimeinfo-perl=0.30-1 \
	libio-socket-inet6-perl=2.72-2.1 \
	libio-socket-ip-perl=0.41-1 \
	libmail-mbox-messageparser-perl=1.5111-2 \
	libperlio-gzip-perl=0.19-1+b7 \
    libmail-imapclient-perl=3.42-1 \
    libmime-tools-perl=5.509-1 \
    libxml-simple-perl=2.25-1 \
    unzip=6.0-26 \
    wget=1.21-1+deb11u1 \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /tmp
RUN wget --no-check-certificate -q https://github.com/techsneeze/dmarcts-report-parser/archive/refs/heads/master.zip \
	&& unzip -q master.zip
WORKDIR /tmp/dmarcts-report-parser-master
RUN mkdir /app \
	&& mv * /app/
WORKDIR /app
RUN rm -r /tmp/master.zip /tmp/dmarcts-report-parser-master
COPY config.inc.conf /app/dmarcts-report-parser.conf
CMD [ "perl", "dmarcts-report-parser.pl", "-i"]