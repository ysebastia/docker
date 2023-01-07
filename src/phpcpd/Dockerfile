FROM docker.io/ysebastia/wget:1.21.3-r2 as downloader

WORKDIR /tmp
RUN wget -q https://phar.phpunit.de/phpcpd-6.0.3.phar -O /tmp/phpcpd

FROM php:8.1.14-cli-alpine3.16
COPY --from=downloader /tmp/phpcpd /usr/local/bin/phpcpd
RUN chmod +x /usr/local/bin/phpcpd
CMD ["/usr/local/bin/phpcpd"]
